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
<<<<<<< HEAD
  String? _selectedCrop; // To store the selected crop

=======
  String? _selectedCrop;
>>>>>>> b11e7d7 (first commit)
  final List<String> _popularCrops = [
    "Kappas (Cotton)",
    "Gandum (Wheat)",
    "Chawal (Rice)",
    "Kamad (Sugarcane)",
    "Makai (Maize)",
    "Sabziyan (Vegetables)",
    "Phal (Fruits)",
  ];

<<<<<<< HEAD
  List<String> _filteredCrops = []; // For search suggestions
=======
  List<String> _filteredCrops = [];
>>>>>>> b11e7d7 (first commit)

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _filteredCrops = _popularCrops; // Initially show all popular crops
=======
    _filteredCrops = _popularCrops;
>>>>>>> b11e7d7 (first commit)
  }

  @override
  void dispose() {
    _cropController.dispose();
    super.dispose();
  }

  void _updateCropSuggestions(String input) {
    if (input.isEmpty) {
<<<<<<< HEAD
      setState(() {
        _filteredCrops = _popularCrops;
      });
=======
      setState(() => _filteredCrops = _popularCrops);
>>>>>>> b11e7d7 (first commit)
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
<<<<<<< HEAD
      _cropController.text = crop; // Update text field with selected crop
      _filteredCrops = []; // Clear suggestions after selection
    });
    FocusScope.of(context).unfocus(); // Keyboard hide kar dein
=======
      _cropController.text = crop;
      _filteredCrops = [];
    });
    FocusScope.of(context).unfocus();
>>>>>>> b11e7d7 (first commit)
  }

  void _proceedToPrediction() {
    if (_selectedCrop == null || _selectedCrop!.isEmpty) {
<<<<<<< HEAD
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
=======
      Fluttertoast.showToast(
        msg: "Please select or enter a crop first.",
        backgroundColor: Theme.of(context).colorScheme.error,
        textColor: Colors.white,
      );
      return;
    }

    Fluttertoast.showToast(
      msg: "Proceeding for prediction of: $_selectedCrop",
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
    );
    print("User wants prediction for: $_selectedCrop");
    // Navigator.push(context, MaterialPageRoute(builder: (_) => PredictionResultScreen(crop: _selectedCrop!)));
>>>>>>> b11e7d7 (first commit)
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.marketPricePrediction, style: AppStyles.buttonTextStyle),
        backgroundColor: AppStyles.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppStyles.whiteColor),
=======
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.marketPricePrediction, style: AppStyles.appBarTitleStyle(context)),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
>>>>>>> b11e7d7 (first commit)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Select or Enter Your Crop",
<<<<<<< HEAD
              style: AppStyles.subTitleStyle,
=======
              style: AppStyles.subTitleStyle(context),
>>>>>>> b11e7d7 (first commit)
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppStyles.defaultPadding),

<<<<<<< HEAD
            // Crop Search/Input Field
=======
            // Crop Search/Input Field with Suggestions
>>>>>>> b11e7d7 (first commit)
            Stack(
              children: [
                TextFormField(
                  controller: _cropController,
                  decoration: InputDecoration(
                    hintText: "e.g., Gandum (Wheat)",
<<<<<<< HEAD
                    prefixIcon: const Icon(Icons.grass, color: AppStyles.primaryColor),
                    suffixIcon: _cropController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: AppStyles.lightTextColor),
=======
                    prefixIcon: Icon(Icons.grass, color: theme.colorScheme.primary),
                    suffixIcon: _cropController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: theme.hintColor),
>>>>>>> b11e7d7 (first commit)
                      onPressed: () {
                        _cropController.clear();
                        setState(() {
                          _selectedCrop = null;
                          _filteredCrops = _popularCrops;
                        });
                      },
                    )
                        : null,
<<<<<<< HEAD
=======
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
                  onChanged: (value) {
                    setState(() => _selectedCrop = value.isEmpty ? null : value);
                    _updateCropSuggestions(value);
                  },
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _onCropSelected(value);
                      _proceedToPrediction();
                    }
                  },
                ),

                // Suggestions Dropdown
                if (_filteredCrops.isNotEmpty && _cropController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 65.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                      ),
                      color: theme.cardColor,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.3,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredCrops.length,
                          itemBuilder: (context, index) {
                            final crop = _filteredCrops[index];
                            return ListTile(
                              title: Text(crop, style: AppStyles.bodyTextStyle(context)),
                              onTap: () => _onCropSelected(crop),
                            );
                          },
                        ),
>>>>>>> b11e7d7 (first commit)
                      ),
                    ),
                  ),
              ],
            ),
<<<<<<< HEAD
=======

>>>>>>> b11e7d7 (first commit)
            const SizedBox(height: AppStyles.defaultPadding * 2),

            // Selected Crop Display
            if (_selectedCrop != null && _selectedCrop!.isNotEmpty)
              Column(
                children: [
                  Text(
                    "You selected:",
<<<<<<< HEAD
                    style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor),
=======
                    style: AppStyles.bodyTextStyle(context).copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
>>>>>>> b11e7d7 (first commit)
                  ),
                  const SizedBox(height: AppStyles.smallPadding),
                  Text(
                    _selectedCrop!,
<<<<<<< HEAD
                    style: AppStyles.subTitleStyle.copyWith(color: AppStyles.primaryColor),
=======
                    style: AppStyles.subTitleStyle(context).copyWith(color: theme.colorScheme.primary),
>>>>>>> b11e7d7 (first commit)
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppStyles.largePadding),
                ],
              ),

            // Proceed Button
            ElevatedButton(
              onPressed: _proceedToPrediction,
<<<<<<< HEAD
=======
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppStyles.defaultPadding),
                textStyle: AppStyles.bodyTextStyle(context).copyWith(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                ),
              ),
>>>>>>> b11e7d7 (first commit)
              child: const Text("Get Price Prediction"),
            ),
          ],
        ),
      ),
    );
  }
}