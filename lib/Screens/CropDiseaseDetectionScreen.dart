// lib/Screens/CropDiseaseDetectionScreen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import '../Utils/ChatLanguages.dart';


class CropDiseaseDetectionScreen extends StatefulWidget {
  const CropDiseaseDetectionScreen({super.key});

  @override
  State<CropDiseaseDetectionScreen> createState() => _CropDiseaseDetectionScreenState();
}

class _CropDiseaseDetectionScreenState extends State<CropDiseaseDetectionScreen> {
  File? _selectedImage;
  String _predictionResult = "";
  bool _isLoading = false;

  // --- Language Selection State ---
  ChatLanguage _selectedLanguage = ChatLanguage.english; // Default language

  // --- API Configuration ---
  final String _apiUrl = 'https://mhamzashahid-crop-disease-detector-api.hf.space/api/predict';
  // You might need a separate API for translation if your disease API doesn't support it directly.
  // For now, we'll assume we either get localized names from the disease API,
  // or we use a local mapping/external translation service.
  // For this example, we'll use a simple hardcoded map for demonstration.
  final Map<String, Map<ChatLanguage, String>> _diseaseTranslations = {
    "Healthy": {
      ChatLanguage.english: "Healthy",
      ChatLanguage.urdu: "صحت مند",
      ChatLanguage.romanUrdu: "Sehatmand",
    },
    "Blight": {
      ChatLanguage.english: "Blight",
      ChatLanguage.urdu: "جھلساؤ",
      ChatLanguage.romanUrdu: "Jhulsao",
    },
    "Leaf Spot": {
      ChatLanguage.english: "Leaf Spot",
      ChatLanguage.urdu: "پتوں پر دھبے",
      ChatLanguage.romanUrdu: "Patton par Dhabbe",
    },
    // Add more disease translations here as needed
    // Example for a more complex name:
    "Tomato mosaic virus": {
      ChatLanguage.english: "Tomato mosaic virus",
      ChatLanguage.urdu: "ٹماٹر موزیک وائرس",
      ChatLanguage.romanUrdu: "Tamatar mosaic virus",
    },
    "Powdery mildew": {
      ChatLanguage.english: "Powdery mildew",
      ChatLanguage.urdu: "سفید پھپھوندی",
      ChatLanguage.romanUrdu: "Safed Phaphundi",
    },
    // Add other potential disease names from your model here
    // If a disease is not found in this map, it will default to English.
  };


  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _predictionResult = ""; // Clear previous prediction
      });
      Fluttertoast.showToast(msg: "Image selected!");
    } else {
      Fluttertoast.showToast(msg: "No image selected.", backgroundColor: AppStyles.errorColor);
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper function to get translated disease name
  String _getTranslatedDiseaseName(String englishName, ChatLanguage language) {
    if (_diseaseTranslations.containsKey(englishName) && _diseaseTranslations[englishName]!.containsKey(language)) {
      return _diseaseTranslations[englishName]![language]!;
    }
    // Fallback to English if translation not found
    return englishName;
  }

  Future<void> _detectDisease() async {
    if (_selectedImage == null) {
      Fluttertoast.showToast(msg: "Please select an image first.", backgroundColor: AppStyles.errorColor);
      return;
    }

    setState(() {
      _isLoading = true;
      _predictionResult = "Detecting...";
    });

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));
      request.files.add(await http.MultipartFile.fromPath('file', _selectedImage!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = jsonDecode(respStr);

        if (responseData['success'] == true && responseData['result'] != null) {
          final result = responseData['result'];
          final String englishDisease = result['predicted_disease'];
          final double confidence = result['confidence'];

          // --- Translate the disease name based on selected language ---
          final String translatedDisease = _getTranslatedDiseaseName(englishDisease, _selectedLanguage);

          String confidenceText;
          // Translate confidence text as well
          switch (_selectedLanguage) {
            case ChatLanguage.urdu:
              confidenceText = " (اعتماد: ${(confidence * 100).toStringAsFixed(2)}%)";
              break;
            case ChatLanguage.romanUrdu:
              confidenceText = " (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)"; // Roman Urdu often uses English terms or a mix
              break;
            case ChatLanguage.english:
            default:
              confidenceText = " (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)";
              break;
          }

          setState(() {
            _predictionResult = "Predicted: $translatedDisease$confidenceText";
          });
          Fluttertoast.showToast(msg: "Prediction received!");
        } else {
          setState(() {
            _predictionResult = "No prediction data found: ${responseData['error'] ?? 'Unknown error'}";
          });
          Fluttertoast.showToast(msg: "API response error: No data.", backgroundColor: AppStyles.errorColor);
        }
      } else {
        final errorBody = await response.stream.bytesToString();
        setState(() {
          _predictionResult = "Error: ${response.statusCode}\n$errorBody";
        });
        Fluttertoast.showToast(msg: "API request failed: ${response.statusCode}", backgroundColor: AppStyles.errorColor);
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error: $e";
      });
      Fluttertoast.showToast(msg: "An error occurred: $e", backgroundColor: AppStyles.errorColor);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.cropDiseaseDetection),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // --- Language Selector Dropdown ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppStyles.defaultPadding),
                margin: const EdgeInsets.only(bottom: AppStyles.defaultPadding),
                decoration: BoxDecoration(
                  color: AppStyles.backgroundColor,
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  border: Border.all(color: AppStyles.primaryColor, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ChatLanguage>(
                    value: _selectedLanguage,
                    icon: const Icon(Icons.arrow_drop_down, color: AppStyles.primaryColor),
                    elevation: 16,
                    style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.textColor),
                    onChanged: (ChatLanguage? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                        // Optionally, re-translate the current prediction if any
                        if (_predictionResult.isNotEmpty && !_isLoading) {
                          // This part requires parsing the _predictionResult back to get the English name
                          // For a more robust solution, you should store the raw English disease name separately.
                          // For now, let's just clear it or keep it as is.
                          _predictionResult = ""; // Clear for simplicity or re-run detection for full translation
                        }
                      });
                    },
                    items: ChatLanguage.values.map<DropdownMenuItem<ChatLanguage>>((ChatLanguage language) {
                      return DropdownMenuItem<ChatLanguage>(
                        value: language,
                        child: Text(language.toDisplayString()),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: AppStyles.defaultPadding),

              _selectedImage == null
                  ? Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppStyles.backgroundColor,
                  border: Border.all(color: AppStyles.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                ),
                child: const Icon(
                  Icons.image,
                  size: 100,
                  color: AppStyles.primaryColor,
                ),
              )
                  : Image.file(
                _selectedImage!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: AppStyles.largePadding),
              ElevatedButton.icon(
                onPressed: _showImageSourceOptions,
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text("Pick Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  foregroundColor: AppStyles.whiteColor,
                  padding: const EdgeInsets.symmetric(horizontal: AppStyles.largePadding, vertical: AppStyles.defaultPadding),
                  textStyle: AppStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: AppStyles.defaultPadding),
              if (_selectedImage != null)
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _detectDisease,
                  icon: _isLoading ? const CircularProgressIndicator(color: AppStyles.whiteColor) : const Icon(Icons.search),
                  label: Text(_isLoading ? "Detecting..." : "Detect Disease"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.accentColor,
                    foregroundColor: AppStyles.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: AppStyles.largePadding, vertical: AppStyles.defaultPadding),
                    textStyle: AppStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(height: AppStyles.largePadding),
              if (_predictionResult.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(AppStyles.defaultPadding),
                  decoration: BoxDecoration(
                    color: AppStyles.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                    border: Border.all(color: AppStyles.primaryColor),
                  ),
                  child: Column(
                    children: [
                      Text(
                        // Translate "Prediction:" as well
                        _selectedLanguage == ChatLanguage.urdu ? "پیش گوئی:" : (_selectedLanguage == ChatLanguage.romanUrdu ? "Prediction:" : "Prediction:"),
                        style: AppStyles.headingTextStyle.copyWith(color: AppStyles.primaryColor),
                        // Add text direction for Urdu
                        textDirection: _selectedLanguage == ChatLanguage.urdu ? TextDirection.rtl : TextDirection.ltr,
                      ),
                      const SizedBox(height: AppStyles.smallPadding),
                      Text(
                        _predictionResult,
                        textAlign: TextAlign.center,
                        style: AppStyles.bodyTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                        // Add text direction for Urdu
                        textDirection: _selectedLanguage == ChatLanguage.urdu ? TextDirection.rtl : TextDirection.ltr,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}