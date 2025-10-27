// lib/Screens/CropYieldPredictor.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:dropdown_search/dropdown_search.dart'; // Ensure this import is present

import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';

class CropYeildPridictor extends StatefulWidget {
  const CropYeildPridictor({super.key});

  @override
  State<CropYeildPridictor> createState() => _CropYeildPridictorState();
}

class _CropYeildPridictorState extends State<CropYeildPridictor> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _avgRainfallController = TextEditingController();
  final TextEditingController _pesticidesController = TextEditingController();
  final TextEditingController _avgTemperatureController = TextEditingController();

  String? _selectedCropType;
  String? _selectedYear;
  String? _selectedCountry;

  final List<String> _countries = [
    'Albania', 'Algeria', 'Angola', 'Argentina', 'Australia', 'Bangladesh', 'Brazil',
    'Canada', 'China', 'Egypt', 'France', 'Germany', 'India', 'Indonesia', 'Iran',
    'Italy', 'Japan', 'Kenya', 'Malaysia', 'Mexico', 'Morocco', 'Nepal', 'Netherlands',
    'New Zealand', 'Nigeria', 'Pakistan', 'Philippines', 'Poland', 'Russia', 'Saudi Arabia',
    'South Africa', 'Spain', 'Sri Lanka', 'Thailand', 'Turkey', 'Uganda', 'UK', 'USA',
    'Vietnam', 'Zimbabwe',
  ];

  final List<String> _cropTypes = [
    'Barley', 'Cassava', 'Cotton', 'Maize', 'Potatoes', 'Rice', 'Sorghum',
    'Soybeans', 'Sugarcane', 'Sweet potatoes', 'Wheat', 'Yams',
  ];

  final List<String> _years = [
    for (int i = 1997; i <= 2035; i++) i.toString(),
  ];

  String _predictionResult = "Enter values and predict";
  bool _isLoading = false;

  final String _apiUrl = 'https://mhamzashahid-crop-yield-predictor-api.hf.space/predict';

  Future<void> _predictCropYield() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please fill all fields correctly.");
      return;
    }
    if (_selectedCropType == null || _selectedYear == null || _selectedCountry == null) {
      Fluttertoast.showToast(msg: "Please select Country, Crop, and Year.");
      return;
    }

    setState(() {
      _isLoading = true;
      _predictionResult = "Predicting...";
    });

    try {
      final requestBody = {
        "Area": _selectedCountry!,
        "Item": _selectedCropType!,
        "Year": int.parse(_selectedYear!),
        "average_rain_fall_mm_per_year": double.parse(_avgRainfallController.text),
        "pesticides_tonnes": double.parse(_pesticidesController.text),
        "avg_temp": double.parse(_avgTemperatureController.text),
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final yieldKgPerHa = data['predicted_yield_kg_per_ha'] as double;
        final yieldHgPerHa = data['predicted_yield_hg_per_ha'] ?? yieldKgPerHa * 10;

        final qualityMessage = _getQualityMessage(yieldKgPerHa);

        final formattedResult = '''
# Prediction Results

**Predicted Yield:** **`${_formatNumber(yieldKgPerHa)} kg/ha`** (`${_formatNumber(yieldHgPerHa)} hg/ha`)

## Input Summary

*   **Area:** ${_selectedCountry!}
*   **Item:** ${_selectedCropType!.toLowerCase()}
*   **Year:** ${_selectedYear!}
*   **Rainfall:** ${_avgRainfallController.text} mm/year
*   **Pesticides:** ${_pesticidesController.text} tonnes
*   **Temperature:** ${_avgTemperatureController.text}°C

---

\`$qualityMessage\`
''';

        setState(() {
          _predictionResult = formattedResult;
        });
        Fluttertoast.showToast(msg: "Prediction successful!");
      } else {
        setState(() {
          _predictionResult = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    );
  }

  String _getQualityMessage(double yieldKgPerHa) {
    if (yieldKgPerHa > 5000) {
      return "Excellent yield predicted! Optimal conditions detected.";
    } else if (yieldKgPerHa > 3000) {
      return "Good yield predicted. Conditions are favorable.";
    } else {
      return "Moderate yield predicted. Consider optimizing inputs.";
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isNumeric = false,
    TextInputType keyboardType = TextInputType.text,
    String? suffixText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.smallPadding),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixText: suffixText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter $label';
          if (isNumeric && double.tryParse(value) == null) return 'Invalid number';
          return null;
        },
      ),
    );
  }

  // ✅ Updated Dropdown field, fully compatible with dropdown_search package version 5.x.x
  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required String? selectedValue,
    required void Function(String?) onChanged,
    bool isYear = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.smallPadding),
      child: DropdownSearch<String>(
        items: items,
        selectedItem: selectedValue,
        // Configuration for the dropdown popup (where the search box appears)
        popupProps: const PopupProps.menu(
          showSearchBox: true, // Enable search box in the popup
        ),
        // Configuration for the appearance of the dropdown button itself
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
            ),
          ),
        ),
        // ✅ Here's the updated dropdownButtonProps for the clear icon
        dropdownButtonProps: DropdownButtonProps(
          // default icon is Icons.arrow_drop_down.
          // You can choose to show it all the time or only when no item is selected
          icon: selectedValue == null ? const Icon(Icons.arrow_drop_down) : const Icon(Icons.clear),
          isVisible: true, // Always show the button area
          onPressed: selectedValue == null
              ? null // No action if nothing is selected (default dropdown behavior)
              : () {
            // If an item is selected, pressing the icon clears it.
            onChanged(null);
          },
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select or enter $label';
          }
          if (isYear) {
            final year = int.tryParse(value);
            if (year == null || year < 1997) {
              return 'Year must be 1997 or later';
            }
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }

  @override
  void dispose() {
    _avgRainfallController.dispose();
    _pesticidesController.dispose();
    _avgTemperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.CropYieldForcaster,
            style: AppStyles.appBarTitleStyle(context)),
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Enter Crop Prediction Features",
                style: AppStyles.headingTextStyle(context)
                    .copyWith(color: AppStyles.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.largePadding),

              _buildDropdownField(
                label: "Country/Area",
                items: _countries,
                selectedValue: _selectedCountry,
                onChanged: (v) => setState(() => _selectedCountry = v),
              ),
              _buildDropdownField(
                label: "Crop Type",
                items: _cropTypes,
                selectedValue: _selectedCropType,
                onChanged: (v) => setState(() => _selectedCropType = v),
              ),
              _buildDropdownField(
                label: "Year",
                items: _years,
                selectedValue: _selectedYear,
                onChanged: (v) => setState(() => _selectedYear = v),
                isYear: true,
              ),
              _buildInputField(
                controller: _avgRainfallController,
                label: "Avg Rainfall",
                hint: "e.g., 1200.5",
                isNumeric: true,
                keyboardType: TextInputType.number,
                suffixText: "mm/year",
              ),
              _buildInputField(
                controller: _pesticidesController,
                label: "Pesticides",
                hint: "e.g., 500.25",
                isNumeric: true,
                keyboardType: TextInputType.number,
                suffixText: "tonnes",
              ),
              _buildInputField(
                controller: _avgTemperatureController,
                label: "Avg Temperature",
                hint: "e.g., 25.3",
                isNumeric: true,
                keyboardType: TextInputType.number,
                suffixText: "°C",
              ),

              const SizedBox(height: AppStyles.largePadding),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _predictCropYield,
                icon: _isLoading
                    ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.analytics_outlined),
                label: Text(_isLoading ? "Predicting..." : "Predict Crop Yield"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppStyles.largePadding,
                      vertical: AppStyles.defaultPadding),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius)),
                ),
              ),

              const SizedBox(height: AppStyles.largePadding),

              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(AppStyles.defaultBorderRadius + 4)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.largePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Prediction Result:",
                          style: AppStyles.headingTextStyle(context)
                              .copyWith(fontSize: 20, color: AppStyles.primaryColor)),
                      const SizedBox(height: AppStyles.defaultPadding),
                      const Divider(height: 1),
                      const SizedBox(height: AppStyles.defaultPadding),
                      MarkdownBody(
                        data: _predictionResult,
                        styleSheet: MarkdownStyleSheet(
                          h1: AppStyles.headlineStyle(context)
                              .copyWith(color: AppStyles.primaryColor),
                          h2: AppStyles.subTitleStyle(context)
                              .copyWith(color: AppStyles.primaryColor),
                          strong: AppStyles.bodyTextStyle(context)
                              .copyWith(fontWeight: FontWeight.bold),
                          em: AppStyles.bodyTextStyle(context)
                              .copyWith(fontStyle: FontStyle.italic),
                          p: AppStyles.bodyTextStyle(context),
                          code: TextStyle(
                            backgroundColor: AppStyles.primaryColor.withOpacity(0.1),
                            color: AppStyles.primaryColor,
                            fontFamily: 'monospace',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          horizontalRuleDecoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppStyles.primaryColor.withOpacity(0.4)))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}