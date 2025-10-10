// lib/Screens/FertilizerRecommendationScreen.dart

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';

class FertilizerRecommendationScreen extends StatefulWidget {
  const FertilizerRecommendationScreen({super.key});

  @override
  State<FertilizerRecommendationScreen> createState() => _FertilizerRecommendationScreenState();
}

class _FertilizerRecommendationScreenState extends State<FertilizerRecommendationScreen> {
  final TextEditingController _cropNameController = TextEditingController();
  String? _selectedCrop; // Dropdown ke liye
  String _recommendationResult = "";
  bool _isLoading = false;

  // Example list of crops for dropdown
  final List<String> _crops = [
    'Wheat',
    'Rice',
    'Maize',
    'Cotton',
    'Sugarcane',
    'Potato',
    'Tomato',
    'Chilli',
    'Mango',
    'Orange',
    'Banana',
  ];

  @override
  void dispose() {
    _cropNameController.dispose();
    super.dispose();
  }

  void _getFertilizerRecommendation() async {
    if (_selectedCrop == null || _selectedCrop!.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a crop first!", backgroundColor: AppStyles.errorColor);
      return;
    }

    setState(() {
      _isLoading = true;
      _recommendationResult = ""; // Clear previous result
    });

    // Simulate an API call or ML model inference for recommendation
    await Future.delayed(const Duration(seconds: 2));

    String crop = _selectedCrop!;
    String result;

    // Dummy recommendation logic based on crop
    if (crop == 'Wheat') {
      result = "For Wheat: Use Urea (120 kg/acre), DAP (50 kg/acre) at sowing.";
    } else if (crop == 'Rice') {
      result = "For Rice: Apply Nitrogen (100 kg/acre), Phosphorus (60 kg/acre) in split doses.";
    } else if (crop == 'Maize') {
      result = "For Maize: NPK (150-100-80 kg/acre) is recommended. Ensure balanced application.";
    } else if (crop == 'Cotton') {
      result = "For Cotton: Focus on Urea (100 kg/acre) and Potash (60 kg/acre) during flowering.";
    } else {
      result = "Recommendation for '$crop': A balanced NPK fertilizer (e.g., 20-20-20) is generally good. Consult local agricultural extension for precise advice.";
    }

    setState(() {
      _recommendationResult = result;
      _isLoading = false;
    });
    Fluttertoast.showToast(msg: "Recommendation Generated!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(AppConstants.fertilizerRecommendation), // <--- SIMPLIFIED
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Select Your Crop",
              style: AppStyles.subTitleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppStyles.defaultPadding),

            // Dropdown to select crop
            DropdownButtonFormField<String>(
              value: _selectedCrop,
              hint: const Text("Choose your crop"),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.grass, color: AppStyles.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppStyles.whiteColor,
              ),
              items: _crops.map((String crop) {
                return DropdownMenuItem<String>(
                  value: crop,
                  child: Text(crop),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCrop = newValue;
                  _recommendationResult = ""; // Clear result on crop change
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a crop';
                }
                return null;
              },
            ),
            const SizedBox(height: AppStyles.largePadding),

            _isLoading
                ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppStyles.primaryColor),
              ),
            )
                : ElevatedButton.icon(
              onPressed: _getFertilizerRecommendation,
              icon: const Icon(Icons.eco),
              label: const Text("Get Recommendation"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.primaryColor,
                foregroundColor: AppStyles.whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: AppStyles.largePadding, vertical: AppStyles.defaultPadding),
                textStyle: AppStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: AppStyles.largePadding),

            if (_recommendationResult.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommendation for $_selectedCrop:",
                    style: AppStyles.subTitleStyle.copyWith(color: AppStyles.primaryColor),
                  ),
                  const SizedBox(height: AppStyles.smallPadding),
                  Container(
                    padding: const EdgeInsets.all(AppStyles.defaultPadding),
                    decoration: BoxDecoration(
                      color: AppStyles.whiteColor,
                      borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      _recommendationResult,
                      style: AppStyles.bodyTextStyle,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}