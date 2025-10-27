import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppConstants.dart';

class DistrictYieldForecastingScreen extends StatefulWidget {
  const DistrictYieldForecastingScreen({super.key});

  @override
  State<DistrictYieldForecastingScreen> createState() =>
      _DistrictYieldForecastingScreenState();
}

class _DistrictYieldForecastingScreenState
    extends State<DistrictYieldForecastingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _cropController = TextEditingController();
  final _seasonController = TextEditingController();
  final _stateController = TextEditingController();
  final _areaController = TextEditingController();
  final _rainfallController = TextEditingController();
  final _fertilizerController = TextEditingController();
  final _pesticideController = TextEditingController();
  final _yearController = TextEditingController();

  String _predictionResult = "Enter values and get forecast";
  bool _isLoading = false;

  final String _apiUrl =
      "https://mhamzashahid-districtyieldforecastingapi.hf.space/predict";

  Future<void> _fetchYieldData() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please fill all fields correctly.");
      return;
    }

    setState(() {
      _isLoading = true;
      _predictionResult = "Fetching forecast...";
    });

    final payload = {
      "crop": _cropController.text,
      "season": _seasonController.text,
      "state": _stateController.text,
      "area": double.tryParse(_areaController.text) ?? 0.0,
      "annual_rainfall": double.tryParse(_rainfallController.text) ?? 0.0,
      "fertilizer": double.tryParse(_fertilizerController.text) ?? 0.0,
      "pesticide": double.tryParse(_pesticideController.text) ?? 0.0,
      "year": int.tryParse(_yearController.text) ?? 0,
    };

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final yieldValue = (data['yield'] ??
            data['predicted_yield'] ??
            data['yield_predicted'] ??
            data['Yield'] ??
            data['Predicted_Yield'])
            ?.toString();

        if (yieldValue == null || yieldValue.isEmpty) {
          setState(() {
            _predictionResult = "No yield data available.";
          });
          return;
        }

        final yieldValNum = double.tryParse(yieldValue) ?? 0;
        final qualityMsg = _getQualityMessage(yieldValNum);

        final formattedResult = '''
# District Yield Forecasting Result

**Predicted Yield:** **`${_formatNumber(yieldValNum)} kg/ha`**

## Input Summary
* **Crop:** ${_cropController.text}
* **Season:** ${_seasonController.text}
* **State:** ${_stateController.text}
* **Area:** ${_areaController.text} hectares
* **Annual Rainfall:** ${_rainfallController.text} mm
* **Fertilizer:** ${_fertilizerController.text} tonnes
* **Pesticide:** ${_pesticideController.text} tonnes
* **Year:** ${_yearController.text}

---

\`$qualityMsg\`
''';

        setState(() {
          _predictionResult = formattedResult;
        });

        Fluttertoast.showToast(msg: "Prediction successful!");
      } else {
        setState(() {
          _predictionResult =
          "Error: Failed to fetch yield data (Status: ${response.statusCode})";
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
    return number.toStringAsFixed(2).replaceAllMapped(
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
    String? suffixText,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.smallPadding),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixText: suffixText,
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
            borderSide: BorderSide(color: theme.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
            borderSide:
            BorderSide(color: AppStyles.primaryColor, width: 2),
          ),
        ).applyDefaults(theme.inputDecorationTheme),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter $label';
          if (isNumeric && double.tryParse(value) == null) {
            return 'Invalid number';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _cropController.dispose();
    _seasonController.dispose();
    _stateController.dispose();
    _areaController.dispose();
    _rainfallController.dispose();
    _fertilizerController.dispose();
    _pesticideController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("District Yield Forecasting",
            style: AppStyles.appBarTitleStyle(context)),
        backgroundColor: AppStyles.primaryColor, // ✅ replaced
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
                "Enter District Forecast Parameters",
                style: AppStyles.headingTextStyle(context)
                    .copyWith(color: AppStyles.primaryColor), // ✅ replaced
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.largePadding),

              // 🌾 Input Fields
              _buildInputField(
                  controller: _cropController,
                  label: "Crop",
                  hint: "e.g., Arecanut"),
              _buildInputField(
                  controller: _seasonController,
                  label: "Season",
                  hint: "e.g., Whole Year"),
              _buildInputField(
                  controller: _stateController,
                  label: "State",
                  hint: "e.g., Assam"),
              _buildInputField(
                  controller: _areaController,
                  label: "Area",
                  hint: "e.g., 73814.0",
                  isNumeric: true,
                  suffixText: "ha"),
              _buildInputField(
                  controller: _rainfallController,
                  label: "Annual Rainfall",
                  hint: "e.g., 2051.4",
                  isNumeric: true,
                  suffixText: "mm"),
              _buildInputField(
                  controller: _fertilizerController,
                  label: "Fertilizer",
                  hint: "e.g., 7024878.38",
                  isNumeric: true,
                  suffixText: "tonnes"),
              _buildInputField(
                  controller: _pesticideController,
                  label: "Pesticide",
                  hint: "e.g., 22882.34",
                  isNumeric: true,
                  suffixText: "tonnes"),
              _buildInputField(
                  controller: _yearController,
                  label: "Year",
                  hint: "e.g., 2024",
                  isNumeric: true),

              const SizedBox(height: AppStyles.largePadding),

              // 🔍 Predict Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _fetchYieldData,
                icon: _isLoading
                    ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.analytics_outlined),
                label: Text(
                    _isLoading ? "Predicting..." : "Predict District Yield"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor, // ✅ replaced
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppStyles.largePadding,
                      vertical: AppStyles.defaultPadding),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(AppStyles.defaultBorderRadius)),
                ),
              ),

              const SizedBox(height: AppStyles.largePadding),

              // 📊 Result Card
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        AppStyles.defaultBorderRadius + 4)),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.largePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Prediction Result:",
                          style: AppStyles.headingTextStyle(context).copyWith(
                              fontSize: 20,
                              color: AppStyles.primaryColor)), // ✅ replaced
                      const SizedBox(height: AppStyles.defaultPadding),
                      const Divider(height: 1),
                      const SizedBox(height: AppStyles.defaultPadding),
                      MarkdownBody(
                        data: _predictionResult,
                        styleSheet: MarkdownStyleSheet(
                          h1: AppStyles.headlineStyle(context)
                              .copyWith(color: AppStyles.primaryColor), // ✅ replaced
                          h2: AppStyles.subTitleStyle(context)
                              .copyWith(color: AppStyles.primaryColor), // ✅ replaced
                          strong: AppStyles.bodyTextStyle(context)
                              .copyWith(fontWeight: FontWeight.bold),
                          em: AppStyles.bodyTextStyle(context)
                              .copyWith(fontStyle: FontStyle.italic),
                          p: AppStyles.bodyTextStyle(context),
                          code: TextStyle(
                            backgroundColor:
                            AppStyles.primaryColor.withOpacity(0.1), // ✅ replaced
                            color: AppStyles.primaryColor, // ✅ replaced
                            fontFamily: 'monospace',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          horizontalRuleDecoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Theme.of(context).dividerColor))),
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
