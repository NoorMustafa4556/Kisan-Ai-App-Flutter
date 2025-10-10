// lib/Screens/MarketPriceScreen.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';

class MarketPriceScreen extends StatefulWidget {
  const MarketPriceScreen({super.key});

  @override
  State<MarketPriceScreen> createState() => _MarketPriceScreenState();
}

class _MarketPriceScreenState extends State<MarketPriceScreen> {
  final TextEditingController _cropController = TextEditingController();
  String? _selectedCrop; // To store the selected crop

  final List<String> _popularCrops = [
    "Kappas (Cotton)",
    "Gandum (Wheat)",
    "Chawal (Rice)",
    "Kamad (Sugarcane)",
    "Makai (Maize)",
    "Sabziyan (Vegetables)",
    "Phal (Fruits)",
  ];

  List<String> _filteredCrops = []; // For search suggestions

  @override
  void initState() {
    super.initState();
    _filteredCrops = _popularCrops; // Initially show all popular crops
  }

  @override
  void dispose() {
    _cropController.dispose();
    super.dispose();
  }

  void _updateCropSuggestions(String input) {
    if (input.isEmpty) {
      setState(() {
        _filteredCrops = _popularCrops;
      });
      return;
    }
    setState(() {
      _filteredCrops = _popularCrops
          .where((crop) => crop.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void _onCropSelected(String crop) {
    setState(() {
      _selectedCrop = crop;
      _cropController.text = crop; // Update text field with selected crop
      _filteredCrops = []; // Clear suggestions after selection
    });
    FocusScope.of(context).unfocus(); // Keyboard hide kar dein
  }

  void _proceedToPrediction() {
    if (_selectedCrop == null || _selectedCrop!.isEmpty) {
      Fluttertoast.showToast(msg: "Please select or enter a crop first.",
          backgroundColor: AppStyles.errorColor, textColor: AppStyles.whiteColor);
      return;
    }
    // TODO: Yahan se agle step par jayenge, jahan model integrate hoga
    // Abhi ke liye sirf toast message dikha rahe hain
    Fluttertoast.showToast(msg: "Proceeding for prediction of: $_selectedCrop",
        backgroundColor: AppStyles.primaryColor, textColor: AppStyles.whiteColor);
    print("User wants prediction for: $_selectedCrop");
    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionResultScreen(crop: _selectedCrop!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.marketPricePrediction, style: AppStyles.buttonTextStyle),
        backgroundColor: AppStyles.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppStyles.whiteColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Select or Enter Your Crop",
              style: AppStyles.subTitleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppStyles.defaultPadding),

            // Crop Search/Input Field
            Stack(
              children: [
                TextFormField(
                  controller: _cropController,
                  decoration: InputDecoration(
                    hintText: "e.g., Gandum (Wheat)",
                    prefixIcon: const Icon(Icons.grass, color: AppStyles.primaryColor),
                    suffixIcon: _cropController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: AppStyles.lightTextColor),
                      onPressed: () {
                        _cropController.clear();
                        setState(() {
                          _selectedCrop = null;
                          _filteredCrops = _popularCrops;
                        });
                      },
                    )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppStyles.whiteColor,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedCrop = value.isEmpty ? null : value; // Update selected crop on type
                    });
                    _updateCropSuggestions(value);
                  },
                  onFieldSubmitted: (value) {
                    if(value.isNotEmpty) {
                      _onCropSelected(value); // Directly select if entered
                      _proceedToPrediction(); // Proceed after submitting
                    }
                  },
                ),
                if (_filteredCrops.isNotEmpty && _cropController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 65.0), // Adjust as needed
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppStyles.whiteColor,
                        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                        boxShadow: [
                          BoxShadow(color: AppStyles.blackColor.withOpacity(0.1), blurRadius: 5, spreadRadius: 1),
                        ],
                      ),
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3), // Max height for suggestions
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredCrops.length,
                        itemBuilder: (context, index) {
                          final crop = _filteredCrops[index];
                          return ListTile(
                            title: Text(crop, style: AppStyles.bodyTextStyle),
                            onTap: () => _onCropSelected(crop),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppStyles.defaultPadding * 2),

            // Selected Crop Display
            if (_selectedCrop != null && _selectedCrop!.isNotEmpty)
              Column(
                children: [
                  Text(
                    "You selected:",
                    style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor),
                  ),
                  const SizedBox(height: AppStyles.smallPadding),
                  Text(
                    _selectedCrop!,
                    style: AppStyles.subTitleStyle.copyWith(color: AppStyles.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppStyles.largePadding),
                ],
              ),

            // Proceed Button
            ElevatedButton(
              onPressed: _proceedToPrediction,
              child: const Text("Get Price Prediction"),
            ),
          ],
        ),
      ),
    );
  }
}