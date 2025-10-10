// lib/Screens/FertilizerRecommendationScreen.dart

import 'package:flutter/material.dart';
<<<<<<< HEAD

=======
>>>>>>> b11e7d7 (first commit)
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';

class FertilizerRecommendationScreen extends StatefulWidget {
  const FertilizerRecommendationScreen({super.key});

  @override
  State<FertilizerRecommendationScreen> createState() => _FertilizerRecommendationScreenState();
}

class _FertilizerRecommendationScreenState extends State<FertilizerRecommendationScreen> {
<<<<<<< HEAD
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
=======
  String? _selectedCrop;
  String _recommendationResult = ""; // Fixed: Was "thousands"
  bool _isLoading = false;

  final List<String> _crops = [
    'Wheat', 'Rice', 'Maize', 'Cotton', 'Sugarcane', 'Potato',
    'Tomato', 'Chilli', 'Mango', 'Orange', 'Banana',
>>>>>>> b11e7d7 (first commit)
  ];

  @override
  void dispose() {
<<<<<<< HEAD
    _cropNameController.dispose();
=======
>>>>>>> b11e7d7 (first commit)
    super.dispose();
  }

  void _getFertilizerRecommendation() async {
    if (_selectedCrop == null || _selectedCrop!.isEmpty) {
<<<<<<< HEAD
      Fluttertoast.showToast(msg: "Please select a crop first!", backgroundColor: AppStyles.errorColor);
=======
      Fluttertoast.showToast(
        msg: "Please select a crop first!",
        backgroundColor: Theme.of(context).colorScheme.error,
        textColor: Colors.white,
      );
>>>>>>> b11e7d7 (first commit)
      return;
    }

    setState(() {
      _isLoading = true;
<<<<<<< HEAD
      _recommendationResult = ""; // Clear previous result
    });

    // Simulate an API call or ML model inference for recommendation
=======
      _recommendationResult = "";
    });

    // Simulate API delay
>>>>>>> b11e7d7 (first commit)
    await Future.delayed(const Duration(seconds: 2));

    String crop = _selectedCrop!;
    String result;

<<<<<<< HEAD
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
=======
    // Dummy recommendation logic
    switch (crop) {
      case 'Wheat':
        result = "For Wheat: Use Urea (120 kg/acre), DAP (50 kg/acre) at sowing.";
        break;
      case 'Rice':
        result = "For Rice: Apply Nitrogen (100 kg/acre), Phosphorus (60 kg/acre) in split doses.";
        break;
      case 'Maize':
        result = "For Maize: NPK (150-100-80 kg/acre) is recommended. Ensure balanced application.";
        break;
      case 'Cotton':
        result = "For Cotton: Focus on Urea (100 kg/acre) and Potash (60 kg/acre) during flowering.";
        break;
      default:
        result = "Recommendation for '$crop': A balanced NPK fertilizer (e.g., 20-20-20) is generally good. Consult local agricultural extension for precise advice.";
>>>>>>> b11e7d7 (first commit)
    }

    setState(() {
      _recommendationResult = result;
      _isLoading = false;
    });
<<<<<<< HEAD
    Fluttertoast.showToast(msg: "Recommendation Generated!");
=======

    Fluttertoast.showToast(
      msg: "Recommendation Generated!",
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
    );
>>>>>>> b11e7d7 (first commit)
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(

        title: Text(AppConstants.fertilizerRecommendation), // <--- SIMPLIFIED
=======
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.fertilizerRecommendation),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
>>>>>>> b11e7d7 (first commit)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
<<<<<<< HEAD
          children: <Widget>[
            Text(
              "Select Your Crop",
              style: AppStyles.subTitleStyle,
=======
          children: [
            Text(
              "Select Your Crop",
              style: AppStyles.subTitleStyle(context),
>>>>>>> b11e7d7 (first commit)
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppStyles.defaultPadding),

<<<<<<< HEAD
            // Dropdown to select crop
=======
            // Dropdown
>>>>>>> b11e7d7 (first commit)
            DropdownButtonFormField<String>(
              value: _selectedCrop,
              hint: const Text("Choose your crop"),
              decoration: InputDecoration(
<<<<<<< HEAD
                prefixIcon: const Icon(Icons.grass, color: AppStyles.primaryColor),
=======
                prefixIcon: Icon(Icons.grass, color: theme.colorScheme.primary),
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor,
>>>>>>> b11e7d7 (first commit)
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  borderSide: BorderSide.none,
                ),
<<<<<<< HEAD
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
=======
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                ),
              ).applyDefaults(theme.inputDecorationTheme),
              items: _crops.map((crop) {
                return DropdownMenuItem(value: crop, child: Text(crop));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCrop = value;
                  _recommendationResult = "";
                });
              },
              validator: (value) => value == null ? 'Please select a crop' : null,
            ),

            const SizedBox(height: AppStyles.largePadding),

            // Button
            _isLoading
                ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
>>>>>>> b11e7d7 (first commit)
              ),
            )
                : ElevatedButton.icon(
              onPressed: _getFertilizerRecommendation,
              icon: const Icon(Icons.eco),
              label: const Text("Get Recommendation"),
              style: ElevatedButton.styleFrom(
<<<<<<< HEAD
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
=======
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyles.largePadding,
                  vertical: AppStyles.defaultPadding,
                ),
                textStyle: AppStyles.bodyTextStyle(context).copyWith(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                ),
              ),
            ),

            const SizedBox(height: AppStyles.largePadding),

            // Result Card
            if (_recommendationResult.isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                ),
                color: theme.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Fixed: Was "27"
                    children: [
                      Text(
                        "Recommendation for $_selectedCrop:",
                        style: AppStyles.subTitleStyle(context).copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: AppStyles.smallPadding),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppStyles.defaultPadding),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          _recommendationResult,
                          style: AppStyles.bodyTextStyle(context),
                        ),
                      ),
                    ],
                  ),
                ),
>>>>>>> b11e7d7 (first commit)
              ),
          ],
        ),
      ),
    );
  }
}