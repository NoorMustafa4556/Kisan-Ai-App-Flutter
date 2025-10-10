import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart'; // Import flutter_markdown

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
    'Albania',
    'Algeria',
    'Angola',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Belarus',
    'Belgium',
    'Botswana',
    'Brazil',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chile',
    'China',
    'Colombia',
    'Croatia',
    'Denmark',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Eritrea',
    'Estonia',
    'Finland',
    'France',
    'Germany',
    'Ghana',
    'Greece',
    'Guatemala',
    'Guinea',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'India',
    'Indonesia',
    'Iraq',
    'Ireland',
    'Italy',
    'Jamaica',
    'Japan',
    'Kazakhstan',
    'Kenya',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Libya',
    'Lithuania',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Mali',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Namibia',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Norway',
    'Pakistan',
    'Papua New Guinea',
    'Peru',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Rwanda',
    'Saudi Arabia',
    'Senegal',
    'Slovenia',
    'South Africa',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Tajikistan',
    'Thailand',
    'Tunisia',
    'Turkey',
    'Uganda',
    'Ukraine',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Zambia',
    'Zimbabwe',
  ];

  final List<String> _cropTypes = [
    'Barley',
    'Cassava',
    'Cotton',
    'Maize',
    'Plantains and others',
    'Potatoes',
    'Rice',
    'Rice, paddy',
    'Sorghum',
    'Soybeans',
    'Sugarcane',
    'Sweet potatoes',
    'Wheat',
    'Yams',
  ];

  final List<String> _years = [
    '2020', '2021', '2022', '2023', '2024'
  ];

  String _predictionResult = "Enter values and predict";
  bool _isLoading = false;

  final String _apiUrl = 'https://mhamzashahid-crop-yield-predictor-api.hf.space/predict';

  Future<void> _predictCropYield() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please fill all required fields correctly.");
      return;
    }
    if (_selectedCropType == null || _selectedYear == null || _selectedCountry == null) {
      Fluttertoast.showToast(msg: "Please select Country, Crop Type and Year.");
      return;
    }

    setState(() {
      _isLoading = true;
      _predictionResult = "Predicting...";
    });

    try {
      final Map<String, dynamic> requestBody = {
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
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('predicted_yield_kg_per_ha')) {
          final double yieldKgPerHa = responseData['predicted_yield_kg_per_ha'];
          final double yieldHgPerHa = responseData['predicted_yield_hg_per_ha'] ?? yieldKgPerHa * 10;

          String qualityMessage = _getQualityMessage(yieldKgPerHa);

          final String formattedResult = '''
# 🌾 Prediction Results

**Predicted Yield:** **`${_formatNumber(yieldKgPerHa)} kg/ha`** (`${_formatNumber(yieldHgPerHa)} hg/ha`)

## Input Summary

*   **Area:** ${_selectedCountry!}
*   **Item:** ${_selectedCropType!.toLowerCase()}
*   **Year:** ${_selectedYear!}
*   **Rainfall:** ${_avgRainfallController.text} mm/year
*   **Pesticides:** ${_pesticidesController.text} tonnes
*   **Temperature:** ${_avgTemperatureController.text}°C

---

_${qualityMessage}_
''';

          setState(() {
            _predictionResult = formattedResult;
          });
          Fluttertoast.showToast(msg: "Prediction successful!");
        } else {
          setState(() {
            _predictionResult = "Prediction data format error";
          });
        }
      } else {
        setState(() {
          _predictionResult = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error: ${e.toString()}";
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
          (Match m) => '${m[1]},',
    );
  }

  String _getQualityMessage(double yieldKgPerHa) {
    if (yieldKgPerHa > 5000) {
      return "Excellent yield predicted! Optimal conditions detected. This yield is indicative of highly favorable environmental factors and effective agricultural practices.";
    } else if (yieldKgPerHa > 3000) {
      return "Good yield predicted. Conditions are favorable. Further improvements in soil health or irrigation might lead to even better outcomes.";
    } else {
      return "Moderate yield predicted. Consider optimizing inputs such as fertilizer application, pest control, or adjusting crop varieties for better performance in the given conditions.";
    }
  }

  Widget _buildInputField(
      TextEditingController controller, String label, String hint,
      {bool isNumeric = false, TextInputType keyboardType = TextInputType.text, String? suffixText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.smallPadding),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixText: suffixText, // Add suffix text for units
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          ),
          filled: true,
          fillColor: AppStyles.whiteColor, // Changed input field background to white for consistency
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (isNumeric && double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField<T>(
      String label,
      List<T> items,
      T? selectedValue,
      void Function(T?) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.smallPadding),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          ),
          filled: true,
          fillColor: AppStyles.whiteColor, // Changed dropdown field background to white
        ),
        value: selectedValue,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select $label';
          }
          return null;
        },
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
      backgroundColor: AppStyles.backgroundColor, // Set scaffold background
      appBar: AppBar(
        title: Text(AppConstants.CropYieldForcaster, style: AppStyles.buttonTextStyle.copyWith(color: AppStyles.whiteColor)),
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: AppStyles.whiteColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Enter Crop Prediction Parameters",
                style: AppStyles.headingTextStyle.copyWith(color: AppStyles.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.largePadding),

              _buildDropdownField<String>(
                "Country/Area",
                _countries,
                _selectedCountry,
                    (String? newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                  });
                },
              ),
              _buildDropdownField<String>(
                "Crop Type",
                _cropTypes,
                _selectedCropType,
                    (String? newValue) {
                  setState(() {
                    _selectedCropType = newValue;
                  });
                },
              ),
              _buildDropdownField<String>(
                "Year",
                _years,
                _selectedYear,
                    (String? newValue) {
                  setState(() {
                    _selectedYear = newValue;
                  });
                },
              ),
              _buildInputField(_avgRainfallController, "Avg Rainfall", "e.g., 1200.5", isNumeric: true, keyboardType: TextInputType.number, suffixText: "mm/year"),
              _buildInputField(_pesticidesController, "Pesticides", "e.g., 500.25", isNumeric: true, keyboardType: TextInputType.number, suffixText: "tonnes"),
              _buildInputField(_avgTemperatureController, "Avg Temperature", "e.g., 25.3", isNumeric: true, keyboardType: TextInputType.number, suffixText: "°C"),

              const SizedBox(height: AppStyles.largePadding),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _predictCropYield,
                icon: _isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppStyles.whiteColor,
                    strokeWidth: 2,
                  ),
                )
                    : const Icon(Icons.analytics_outlined), // Changed icon
                label: Text(_isLoading ? "Predicting..." : "Predict Crop Yield"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  foregroundColor: AppStyles.whiteColor,
                  padding: const EdgeInsets.symmetric(horizontal: AppStyles.largePadding, vertical: AppStyles.defaultPadding),
                  textStyle: AppStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  ),
                ),
              ),

              const SizedBox(height: AppStyles.largePadding),

              // Result Card updated to use MarkdownBody
              Card(
                elevation: 6, // Increased elevation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius + 4), // Slightly more rounded
                ),
                color: AppStyles.whiteColor, // Card background white
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.largePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prediction Result:",
                        style: AppStyles.headingTextStyle.copyWith(fontSize: 20, color: AppStyles.primaryColor),
                      ),
                      const SizedBox(height: AppStyles.defaultPadding),
                      Divider(color: AppStyles.lightTextColor.withOpacity(0.5)),
                      const SizedBox(height: AppStyles.defaultPadding),
                      MarkdownBody(
                        data: _predictionResult,
                        styleSheet: MarkdownStyleSheet(
                          // Customize heading 1 for "Prediction Results"
                          h1: AppStyles.headlineStyle.copyWith(color: AppStyles.accentColor, fontSize: 24, fontWeight: FontWeight.bold),
                          // Customize heading 2 for "Input Summary"
                          h2: AppStyles.subTitleStyle.copyWith(color: AppStyles.primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                          // Customize bold text (e.g., Predicted Yield value)
                          strong: AppStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.bold, color: AppStyles.textColor, fontSize: 16),
                          // Customize italic text (e.g., quality message)
                          em: AppStyles.bodyTextStyle.copyWith(fontStyle: FontStyle.italic, color: AppStyles.lightTextColor),
                          // Customize paragraph text for general content (also applies to list items by default if not styled separately)
                          p: AppStyles.bodyTextStyle.copyWith(color: AppStyles.textColor),
                          // 'listItem' parameter is no longer supported in recent flutter_markdown versions,
                          // list items will inherit 'p' style or can be styled using 'listIndent'/'listBullet' if needed.

                          // Customize inline code style (for `kg/ha` or `hg/ha`)
                          code: TextStyle(
                            backgroundColor: AppStyles.primaryColor.withOpacity(0.1),
                            color: AppStyles.primaryColor,
                            fontFamily: 'monospace',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          // Customize divider
                          horizontalRuleDecoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppStyles.primaryColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                          ),
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