// lib/Screens/CropDiseaseDetectionScreen.dart
<<<<<<< HEAD
=======

>>>>>>> b11e7d7 (first commit)
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
<<<<<<< HEAD
=======

>>>>>>> b11e7d7 (first commit)
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import '../Utils/ChatLanguages.dart';

<<<<<<< HEAD

=======
>>>>>>> b11e7d7 (first commit)
class CropDiseaseDetectionScreen extends StatefulWidget {
  const CropDiseaseDetectionScreen({super.key});

  @override
  State<CropDiseaseDetectionScreen> createState() => _CropDiseaseDetectionScreenState();
}

class _CropDiseaseDetectionScreenState extends State<CropDiseaseDetectionScreen> {
  File? _selectedImage;
  String _predictionResult = "";
  bool _isLoading = false;

<<<<<<< HEAD
  // --- Language Selection State ---
  ChatLanguage _selectedLanguage = ChatLanguage.english; // Default language

  // --- API Configuration ---
  final String _apiUrl = 'https://mhamzashahid-crop-disease-detector-api.hf.space/api/predict';
  // You might need a separate API for translation if your disease API doesn't support it directly.
  // For now, we'll assume we either get localized names from the disease API,
  // or we use a local mapping/external translation service.
  // For this example, we'll use a simple hardcoded map for demonstration.
=======
  ChatLanguage _selectedLanguage = ChatLanguage.english;

  final String _apiUrl = 'https://mhamzashahid-crop-disease-detector-api.hf.space/api/predict';

>>>>>>> b11e7d7 (first commit)
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
<<<<<<< HEAD
    // Add more disease translations here as needed
    // Example for a more complex name:
=======
>>>>>>> b11e7d7 (first commit)
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
<<<<<<< HEAD
    // Add other potential disease names from your model here
    // If a disease is not found in this map, it will default to English.
  };


=======
  };

>>>>>>> b11e7d7 (first commit)
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
<<<<<<< HEAD
        _predictionResult = ""; // Clear previous prediction
      });
      Fluttertoast.showToast(msg: "Image selected!");
    } else {
      Fluttertoast.showToast(msg: "No image selected.", backgroundColor: AppStyles.errorColor);
=======
        _predictionResult = "";
      });
      Fluttertoast.showToast(msg: "Image selected!");
    } else {
      Fluttertoast.showToast(
        msg: "No image selected.",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
>>>>>>> b11e7d7 (first commit)
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
<<<<<<< HEAD
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
=======
      builder: (bc) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getTranslatedDiseaseName(String englishName, ChatLanguage language) {
    return _diseaseTranslations[englishName]?[language] ?? englishName;
>>>>>>> b11e7d7 (first commit)
  }

  Future<void> _detectDisease() async {
    if (_selectedImage == null) {
<<<<<<< HEAD
      Fluttertoast.showToast(msg: "Please select an image first.", backgroundColor: AppStyles.errorColor);
=======
      Fluttertoast.showToast(
        msg: "Please select an image first.",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
>>>>>>> b11e7d7 (first commit)
      return;
    }

    setState(() {
      _isLoading = true;
      _predictionResult = "Detecting...";
    });

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));
      request.files.add(await http.MultipartFile.fromPath('file', _selectedImage!.path));
<<<<<<< HEAD

=======
>>>>>>> b11e7d7 (first commit)
      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
<<<<<<< HEAD
        final Map<String, dynamic> responseData = jsonDecode(respStr);

        if (responseData['success'] == true && responseData['result'] != null) {
          final result = responseData['result'];
          final String englishDisease = result['predicted_disease'];
          final double confidence = result['confidence'];

          // --- Translate the disease name based on selected language ---
          final String translatedDisease = _getTranslatedDiseaseName(englishDisease, _selectedLanguage);

          String confidenceText;
          // Translate confidence text as well
=======
        final data = jsonDecode(respStr);

        if (data['success'] == true && data['result'] != null) {
          final result = data['result'];
          final englishDisease = result['predicted_disease'];
          final confidence = result['confidence'];

          final translatedDisease = _getTranslatedDiseaseName(englishDisease, _selectedLanguage);

          String confidenceText;
>>>>>>> b11e7d7 (first commit)
          switch (_selectedLanguage) {
            case ChatLanguage.urdu:
              confidenceText = " (اعتماد: ${(confidence * 100).toStringAsFixed(2)}%)";
              break;
            case ChatLanguage.romanUrdu:
<<<<<<< HEAD
              confidenceText = " (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)"; // Roman Urdu often uses English terms or a mix
=======
              confidenceText = " (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)";
>>>>>>> b11e7d7 (first commit)
              break;
            case ChatLanguage.english:
            default:
              confidenceText = " (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)";
<<<<<<< HEAD
              break;
=======
>>>>>>> b11e7d7 (first commit)
          }

          setState(() {
            _predictionResult = "Predicted: $translatedDisease$confidenceText";
          });
          Fluttertoast.showToast(msg: "Prediction received!");
        } else {
          setState(() {
<<<<<<< HEAD
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
=======
            _predictionResult = "Error: ${data['error'] ?? 'No data'}";
          });
          Fluttertoast.showToast(msg: "API error.", backgroundColor: Theme.of(context).colorScheme.error);
        }
      } else {
        final error = await response.stream.bytesToString();
        setState(() {
          _predictionResult = "Error: ${response.statusCode}\n$error";
        });
        Fluttertoast.showToast(msg: "Failed: ${response.statusCode}", backgroundColor: Theme.of(context).colorScheme.error);
>>>>>>> b11e7d7 (first commit)
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error: $e";
      });
<<<<<<< HEAD
      Fluttertoast.showToast(msg: "An error occurred: $e", backgroundColor: AppStyles.errorColor);
=======
      Fluttertoast.showToast(msg: "Error: $e", backgroundColor: Theme.of(context).colorScheme.error);
>>>>>>> b11e7d7 (first commit)
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    final theme = Theme.of(context);
    final isRtl = _selectedLanguage == ChatLanguage.urdu;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.cropDiseaseDetection),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.defaultPadding),
          child: Column(
            children: [
              // Language Dropdown
>>>>>>> b11e7d7 (first commit)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppStyles.defaultPadding),
                margin: const EdgeInsets.only(bottom: AppStyles.defaultPadding),
                decoration: BoxDecoration(
<<<<<<< HEAD
                  color: AppStyles.backgroundColor,
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  border: Border.all(color: AppStyles.primaryColor, width: 1),
=======
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  border: Border.all(color: theme.colorScheme.primary, width: 1),
>>>>>>> b11e7d7 (first commit)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ChatLanguage>(
                    value: _selectedLanguage,
<<<<<<< HEAD
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
=======
                    icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
                    style: AppStyles.bodyTextStyle(context),
                    onChanged: (val) {
                      setState(() {
                        _selectedLanguage = val!;
                        _predictionResult = ""; // Clear for fresh translation
                      });
                    },
                    items: ChatLanguage.values.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang.toDisplayString()),
>>>>>>> b11e7d7 (first commit)
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: AppStyles.defaultPadding),

<<<<<<< HEAD
=======
              // Image Placeholder
>>>>>>> b11e7d7 (first commit)
              _selectedImage == null
                  ? Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
<<<<<<< HEAD
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
=======
                  color: theme.cardColor,
                  border: Border.all(color: theme.colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                ),
                child: Icon(Icons.image, size: 100, color: theme.colorScheme.primary),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                child: Image.file(_selectedImage!, width: 200, height: 200, fit: BoxFit.cover),
              ),

              const SizedBox(height: AppStyles.largePadding),

              // Pick Image Button
>>>>>>> b11e7d7 (first commit)
              ElevatedButton.icon(
                onPressed: _showImageSourceOptions,
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text("Pick Image"),
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
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
=======
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: AppStyles.largePadding, vertical: AppStyles.defaultPadding),
                ),
              ),

              const SizedBox(height: AppStyles.defaultPadding),

              // Detect Button
              if (_selectedImage != null)
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _detectDisease,
                  icon: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.search),
                  label: Text(_isLoading ? "Detecting..." : "Detect Disease"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(horizontal: AppStyles.largePadding, vertical: AppStyles.defaultPadding),
                  ),
                ),

              const SizedBox(height: AppStyles.largePadding),

              // Result Box
              if (_predictionResult.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppStyles.defaultPadding),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                    border: Border.all(color: theme.colorScheme.primary),
>>>>>>> b11e7d7 (first commit)
                  ),
                  child: Column(
                    children: [
                      Text(
<<<<<<< HEAD
                        // Translate "Prediction:" as well
                        _selectedLanguage == ChatLanguage.urdu ? "پیش گوئی:" : (_selectedLanguage == ChatLanguage.romanUrdu ? "Prediction:" : "Prediction:"),
                        style: AppStyles.headingTextStyle.copyWith(color: AppStyles.primaryColor),
                        // Add text direction for Urdu
                        textDirection: _selectedLanguage == ChatLanguage.urdu ? TextDirection.rtl : TextDirection.ltr,
=======
                        _selectedLanguage == ChatLanguage.urdu
                            ? "پیش گوئی:"
                            : (_selectedLanguage == ChatLanguage.romanUrdu ? "Prediction:" : "Prediction:"),
                        style: AppStyles.headingTextStyle(context).copyWith(color: theme.colorScheme.primary),
>>>>>>> b11e7d7 (first commit)
                      ),
                      const SizedBox(height: AppStyles.smallPadding),
                      Text(
                        _predictionResult,
                        textAlign: TextAlign.center,
<<<<<<< HEAD
                        style: AppStyles.bodyTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                        // Add text direction for Urdu
                        textDirection: _selectedLanguage == ChatLanguage.urdu ? TextDirection.rtl : TextDirection.ltr,
=======
                        style: AppStyles.bodyTextStyle(context).copyWith(fontSize: 18, fontWeight: FontWeight.bold),
>>>>>>> b11e7d7 (first commit)
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