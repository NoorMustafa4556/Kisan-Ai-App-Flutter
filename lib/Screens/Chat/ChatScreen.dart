// lib/screens/chat/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as genai;
import 'package:flutter/cupertino.dart';

import '../../Utils/ChatLanguages.dart';
import 'ChatMessage.dart'; // For CupertinoColors

// Local imports

// IMPORTANT: Aapki Gemini API Key yahan add ki ja rahi hai.
// Is key ko public repository par share karne se gurez karein.
const String GEMINI_API_KEY = 'AIzaSyDes6jrXKdbraArYHI-7_B6FLxLvwMGPDM';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  genai.GenerativeModel? _model;
  genai.ChatSession? _chatSession;

  bool _isLoading = false;
  String? _errorMessage;
  ChatLanguage _selectedLanguage = ChatLanguage.romanUrdu; // Default language

  // Initial prompt to set the context for the AI
  final String _systemInstruction = """
You are Kisan AI Advisor, a helpful and knowledgeable assistant specifically designed to provide advice and information related to agriculture, farming, crops, soil, pests, diseases, fertilizers, weather forecasting for farming, and market prices for agricultural produce in Pakistan. 

Your primary goal is to assist farmers with their queries.
- Do not answer questions outside the scope of agriculture. If asked about unrelated topics, politely state that you are an agriculture advisor and can only help with farming-related questions.
- Keep answers concise, practical, and easy for farmers to understand.
- Always respond in the language specified by the user (Roman Urdu, Urdu, or English). If no language is specified, default to Roman Urdu.
- When you start, introduce yourself briefly as Kisan AI Advisor and ask "Main aapko agriculture mein kaise madad kar sakta hoon?" (How can I help you in agriculture?).
""";


  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    // Check if the API key is provided and not the placeholder
    if (GEMINI_API_KEY == 'YOUR_ACTUAL_GEMINI_API_KEY_HERE' ||
        GEMINI_API_KEY.isEmpty) {
      setState(() {
        _errorMessage = "Please provide a valid Gemini API key.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null; // Clear previous errors
    });

    try {
      _model = genai.GenerativeModel(
        model: 'gemini-2.5-flash-image',
        apiKey: GEMINI_API_KEY, // Using the provided API Key
        systemInstruction: genai.Content.text(_systemInstruction),
      );
      _chatSession = _model?.startChat(
          history: [
            genai.Content.model([genai.TextPart("Assalamu Alaikum! Main Kisan AI Advisor hoon. Main aapko agriculture mein kaise madad kar sakta hoon?")])
          ]
      );

      // Add the initial bot message to the chat
      _addMessageToChat("Assalamu Alaikum! Main Kisan AI Advisor hoon. Main aapko agriculture mein kaise madad kar sakta hoon?", false);


    } catch (e) {
      setState(() {
        _errorMessage = "Failed to initialize chat. Check API key and internet connection. Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  Future<void> _sendMessage() async {
    final messageText = _textController.text.trim();
    if (messageText.isEmpty) return;

    if (_chatSession == null) {
      _addMessageToChat("Error: Chat session is not initialized. Please try again or check API key.", false);
      await _initializeChat(); // Try re-initializing
      return;
    }

    _textController.clear();
    _addMessageToChat(messageText, true);

    setState(() {
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      // Prepend language instruction to the user's message
      final String fullPrompt = "Respond in ${_selectedLanguage.toInstructionString()}. User query: $messageText";

      final response = await _chatSession!.sendMessage(
        genai.Content.text(fullPrompt),
      );
      final botResponseText = response.text ?? "Bot sent an empty response.";
      _addMessageToChat(botResponseText, false);
    } catch (e) {
      String errorMsg = "Error: Failed to get response. Please try again. ($e)";
      if (e.toString().contains("429") || e.toString().contains("rate limit")) {
        errorMsg = "Error: Too many requests. Please wait a moment and try again.";
      } else if (e.toString().contains("400") || e.toString().contains("bad request")) {
        errorMsg = "Error: The request was malformed. This might be due to an invalid API key or model issue.";
      }
      _addMessageToChat(errorMsg, false);
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _addMessageToChat(String text, bool isUser) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUserMessage: isUser));
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show error screen if API key is invalid or initialization failed at start
    if (_errorMessage != null && _chatSession == null && !_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ChatBot Error'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _initializeChat,
                icon: const Icon(Icons.refresh),
                label: const Text("Retry Initialization"),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kisan AI Advisor Chat", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: CupertinoColors.activeGreen,
        centerTitle: true,
        actions: [
          // Language selection dropdown
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ChatLanguage>(
                value: _selectedLanguage,
                icon: const Icon(Icons.language, color: Colors.white),
                dropdownColor: Colors.green[700],
                onChanged: (ChatLanguage? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLanguage = newValue;
                    });
                  }
                },
                items: ChatLanguage.values.map<DropdownMenuItem<ChatLanguage>>((ChatLanguage lang) {
                  return DropdownMenuItem<ChatLanguage>(
                    value: lang,
                    child: Text(
                      lang.toDisplayString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        // Your background image setup
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Haadi.jpg"), // Make sure this asset exists
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(
                    text: message.text,
                    isUserMessage: message.isUserMessage,
                    timestamp: message.timestamp,
                  );
                },
              ),
            ),
            if (_isLoading && _chatSession != null)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: LinearProgressIndicator(color: CupertinoColors.activeGreen),
              ),
            const Divider(height: 1),
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.9), // Slightly opaque for background image visibility
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: _buildTextComposer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    bool canSend = !_isLoading && _chatSession != null;
    String hintText = _isLoading
        ? (_chatSession == null
        ? 'Initializing AI Advisor...'
        : 'AI Advisor is typing...')
        : (_chatSession == null
        ? 'Initialization failed.'
        : 'Poocho Kisan AI Advisor se (Ask Kisan AI Advisor)...');

    return IconTheme(
      data: IconThemeData(color: CupertinoColors.activeGreen), // Icon color for send button
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: canSend ? (_) => _sendMessage() : null,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                enabled: canSend,
                minLines: 1,
                maxLines: 5,
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.activeGreen,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: canSend ? _sendMessage : null,
                padding: EdgeInsets.zero, // Remove default padding
                constraints: const BoxConstraints(), // Remove default constraints
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}