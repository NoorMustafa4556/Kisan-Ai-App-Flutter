// lib/Screens/CropDiseaseDetectionScreen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import '../Utils/ChatLanguages.dart';

class CropDiseaseDetectionScreen extends StatefulWidget {
  const CropDiseaseDetectionScreen({super.key});

  @override
  State<CropDiseaseDetectionScreen> createState() => _CropDiseaseDetectionScreenState();
}

class _CropDiseaseDetectionScreenState extends State<CropDiseaseDetectionScreen> {
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;

  String _predictionResult = "";
  bool _isLoading = false;

  ChatLanguage _selectedLanguage = ChatLanguage.english;

  final String _apiUrl = 'https://crazyforai-advancediseasedetection.hf.space/predict';

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
    // Add more translations if needed for other diseases from API
    "Early blight": {
      ChatLanguage.english: "Early blight",
      ChatLanguage.urdu: "ابتدائی جھلساؤ",
      ChatLanguage.romanUrdu: "Ibtidai Jhulsao",
    },
    "Late blight": {
      ChatLanguage.english: "Late blight",
      ChatLanguage.urdu: "دیر سے جھلساؤ",
      ChatLanguage.romanUrdu: "Deer se Jhulsao",
    },
    "Bacterial spot": {
      ChatLanguage.english: "Bacterial spot",
      ChatLanguage.urdu: "بیکٹیریل دھبہ",
      ChatLanguage.romanUrdu: "Bacterial Dhabba",
    },
    // Extend this map as per common API responses
  };

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
          _selectedImageFile = null;
          _predictionResult = "";
        });
      } else {
        setState(() {
          _selectedImageFile = File(pickedFile.path);
          _selectedImageBytes = null;
          _predictionResult = "";
        });
      }
      Fluttertoast.showToast(msg: "Image selected!");
    } else {
      Fluttertoast.showToast(
        msg: "No image selected.",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
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
  }

  Future<void> _detectDisease() async {
    if (_selectedImageFile == null && _selectedImageBytes == null) {
      Fluttertoast.showToast(
        msg: "Please select an image first.",
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _predictionResult = "Detecting...";
    });

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));

      if (kIsWeb && _selectedImageBytes != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          _selectedImageBytes!,
          filename: 'image.jpg',
        ));
      } else if (_selectedImageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('file', _selectedImageFile!.path));
      } else {
        throw Exception("No image data available for upload.");
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = jsonDecode(respStr);

        final String status = data['status'] ?? 'ERROR';
        if (status == 'OK' || status == 'OOD') {
          final String plant = data['plant'] ?? 'Unknown';
          final String disease = data['disease'] ?? 'Unknown';
          final double confidence = (data['confidence'] as num?)?.toDouble() ?? 0.0;
          final String recommendations = data['recommendations'] ?? 'No recommendations available';

          final translatedDisease = _getTranslatedDiseaseName(disease, _selectedLanguage);

          String confidenceText;
          String plantText;
          String diseaseText;
          String recText;
          switch (_selectedLanguage) {
            case ChatLanguage.urdu:
              plantText = "پودا: $plant";
              diseaseText = "بیماری: $translatedDisease";
              confidenceText = " (اعتماد: ${(confidence * 100).toStringAsFixed(2)}%)";
              recText = "تجاویز: $recommendations";
              break;
            case ChatLanguage.romanUrdu:
              plantText = "Poda: $plant";
              diseaseText = "Bimari: $translatedDisease";
              confidenceText = " (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)";
              recText = "Tajawiz: $recommendations";
              break;
            case ChatLanguage.english:
            default:
              plantText = "Plant: $plant";
              diseaseText = "Disease: $translatedDisease";
              confidenceText = " (Confidence: ${(confidence * 100).toStringAsFixed(2)}%)";
              recText = "Recommendations: $recommendations";
          }

          setState(() {
            _predictionResult = "$plantText\n$diseaseText$confidenceText\n$recText";
          });
          Fluttertoast.showToast(msg: "Prediction received!");
        } else {
          setState(() {
            _predictionResult = "Error: ${data['message'] ?? data['detail'] ?? 'No data'}";
          });
          Fluttertoast.showToast(msg: "API error.", backgroundColor: Theme.of(context).colorScheme.error);
        }
      } else {
        final error = await response.stream.bytesToString();
        setState(() {
          _predictionResult = "Error: ${response.statusCode}\n$error";
        });
        Fluttertoast.showToast(msg: "Failed: ${response.statusCode}", backgroundColor: Theme.of(context).colorScheme.error);
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error: $e";
      });
      Fluttertoast.showToast(msg: "Error: $e", backgroundColor: Theme.of(context).colorScheme.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = _selectedLanguage == ChatLanguage.urdu;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.cropDiseaseDetection,style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.defaultPadding),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppStyles.defaultPadding),
                  margin: const EdgeInsets.only(bottom: AppStyles.defaultPadding),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                    border: Border.all(color: AppStyles.primaryColor, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ChatLanguage>(
                      value: _selectedLanguage,
                      icon: Icon(Icons.arrow_drop_down, color: AppStyles.primaryColor),
                      style: AppStyles.bodyTextStyle(context),
                      onChanged: (val) {
                        setState(() {
                          _selectedLanguage = val!;
                          _predictionResult = "";
                        });
                      },
                      items: ChatLanguage.values.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang.toDisplayString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.defaultPadding),

                (_selectedImageBytes == null && _selectedImageFile == null)
                    ? Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    border: Border.all(color: AppStyles.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  ),
                  child: Icon(Icons.image, size: 100, color: AppStyles.primaryColor),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  child: kIsWeb && _selectedImageBytes != null
                      ? Image.memory(_selectedImageBytes!, width: 200, height: 200, fit: BoxFit.cover)
                      : (_selectedImageFile != null
                      ? Image.file(_selectedImageFile!, width: 200, height: 200, fit: BoxFit.cover)
                      : Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: const Center(child: Text("Image Error", style: TextStyle(color: Colors.white))),
                  )),
                ),

                const SizedBox(height: AppStyles.largePadding),

                ElevatedButton.icon(
                  onPressed: _showImageSourceOptions,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text("Pick Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: AppStyles.largePadding, vertical: AppStyles.defaultPadding),
                  ),
                ),

                const SizedBox(height: AppStyles.defaultPadding),

                if (_selectedImageBytes != null || _selectedImageFile != null)
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

                if (_predictionResult.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppStyles.defaultPadding),
                    decoration: BoxDecoration(
                      color: AppStyles.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                      border: Border.all(color: AppStyles.primaryColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _selectedLanguage == ChatLanguage.urdu
                              ? "پیش گوئی:"
                              : (_selectedLanguage == ChatLanguage.romanUrdu ? "Prediction:" : "Prediction:"),
                          style: AppStyles.headingTextStyle(context).copyWith(color: AppStyles.primaryColor),
                        ),
                        const SizedBox(height: AppStyles.smallPadding),
                        Text(
                          _predictionResult,
                          textAlign: TextAlign.center,
                          style: AppStyles.bodyTextStyle(context).copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}