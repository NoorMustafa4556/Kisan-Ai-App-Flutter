// lib/Screens/WeatherScreen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';     // AppStyles import kiya

class WeatherScreen extends StatefulWidget { // Class name updated from WeatherHome to WeatherScreen
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // TODO: Replace with your actual OpenWeatherMap API Key
  // Note: Production apps should store API keys securely, not directly in code.
  final String _apiKey = "d3efac31381a742f9e56142eb96c2341"; // Aapki API key yahan use ki hai

  final TextEditingController _cityController = TextEditingController();

  String? _cityName;
  String? _temperature;
  String? _weatherDescription;
  String? _weatherIcon;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _citySuggestions = [
    "London", "New York", "Paris", "Tokyo", "Delhi", "Sydney", "Moscow",
    "Dubai", "Singapore", "Toronto", "Los Angeles", "Berlin", "Chicago",
    "Madrid", "Rome", "Karachi", "Lahore", "Islamabad", "Mumbai"
  ];

  List<String> _filteredSuggestions = [];

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _updateSuggestions(String input) {
    if (input.isEmpty) {
      setState(() => _filteredSuggestions = []);
      return;
    }
    setState(() {
      _filteredSuggestions = _citySuggestions
          .where((city) => city.toLowerCase().startsWith(input.toLowerCase()))
          .toList();
    });
  }

  Future<void> _fetchWeather(String city) async {
    if (city.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a city name";
        _cityName = null;
        _filteredSuggestions = [];
        _temperature = null; // Clear old data
        _weatherDescription = null;
        _weatherIcon = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _cityName = null;
      _temperature = null;
      _weatherDescription = null;
      _weatherIcon = null;
      _filteredSuggestions = []; // Clear suggestions after search
    });

    final String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _cityName = data['name'];
          _temperature = (data['main']['temp'] as num).toStringAsFixed(1);
          _weatherDescription = data['weather'][0]['description'];
          _weatherIcon = data['weather'][0]['icon'];
        });
      } else {
        final data = json.decode(response.body);
        String message = data['message'] ?? "City not found or error fetching data.";
        setState(() => _errorMessage = message[0].toUpperCase() + message.substring(1));
      }
    } catch (e) {
      setState(() => _errorMessage = "Failed to load weather data. Check your connection.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: "Enter City Name",
      labelStyle: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor),
      filled: true,
      fillColor: AppStyles.whiteColor.withOpacity(0.9), // AppStyles.whiteColor use kiya
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius), borderSide: BorderSide.none), // AppStyles use kiya
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius), borderSide: BorderSide.none), // AppStyles use kiya
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius), // AppStyles use kiya
        borderSide: const BorderSide(color: AppStyles.primaryColor, width: 2), // AppStyles.primaryColor use kiya
      ),
      prefixIcon: const Icon(Icons.location_city, color: AppStyles.primaryColor), // AppStyles use kiya
      suffixIcon: IconButton(
        icon: const Icon(Icons.search, color: AppStyles.primaryColor), // AppStyles use kiya
        onPressed: () {
          _fetchWeather(_cityController.text.trim());
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppStyles.whiteColor), // AppStyles use kiya
        title: Text(
          AppConstants.weatherForecasting, // AppConstants se title liya
          style: AppStyles.buttonTextStyle, // AppStyles use kiya
        ),
        backgroundColor: AppStyles.primaryColor, // AppStyles use kiya
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        // AppStyles colors ke mutabiq gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppStyles.primaryColor.withOpacity(0.7), AppStyles.primaryColor.withOpacity(0.9)], // Primary color shades use kiye
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppStyles.defaultPadding, AppStyles.defaultPadding, AppStyles.defaultPadding, 0), // AppStyles use kiya
          child: Column(
            children: <Widget>[
              // Search field aur suggestions
              Stack(
                children: [
                  TextField(
                    controller: _cityController,
                    decoration: _inputDecoration(),
                    style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.textColor), // Input text style set kiya
                    onChanged: _updateSuggestions,
                    onSubmitted: (value) {
                      _fetchWeather(value.trim());
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  if (_filteredSuggestions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 65.0),
                      child: Container(
                        height: (_filteredSuggestions.length * 55.0).clamp(0, 220.0),
                        decoration: BoxDecoration(
                          color: AppStyles.whiteColor, // AppStyles use kiya
                          borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius), // AppStyles use kiya
                          boxShadow: [
                            BoxShadow(color: AppStyles.blackColor.withOpacity(0.1), blurRadius: 5, spreadRadius: 1), // AppStyles use kiya
                          ],
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _filteredSuggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = _filteredSuggestions[index];
                            return ListTile(
                              title: Text(suggestion, style: AppStyles.bodyTextStyle), // AppStyles use kiya
                              onTap: () {
                                _cityController.text = suggestion;
                                setState(() => _filteredSuggestions = []);
                                _fetchWeather(suggestion);
                                FocusScope.of(context).unfocus();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppStyles.defaultPadding), // AppStyles use kiya
              // Weather display area
              Expanded(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: AppStyles.whiteColor) // AppStyles use kiya
                      : _errorMessage != null
                      ? Text(
                    _errorMessage!,
                    style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.whiteColor, fontWeight: FontWeight.bold), // AppStyles use kiya
                    textAlign: TextAlign.center,
                  )
                      : _cityName == null
                      ? // Behtar initial message
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wb_cloudy_outlined, size: 80, color: AppStyles.whiteColor), // AppStyles use kiya
                      const SizedBox(height: AppStyles.defaultPadding), // AppStyles use kiya
                      Text(
                        "Search for a city to see the weather",
                        style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.whiteColor), // AppStyles use kiya
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                      : // Weather display card
                  Card(
                    color: AppStyles.whiteColor.withOpacity(0.85), // AppStyles use kiya
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius * 2)), // AppStyles use kiya
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(AppStyles.largePadding), // AppStyles use kiya
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (_weatherIcon != null)
                            Image.network(
                              "https://openweathermap.org/img/wn/$_weatherIcon@4x.png",
                              width: 120,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.cloud_off, size: 80, color: AppStyles.lightTextColor), // AppStyles use kiya
                            ),
                          const SizedBox(height: AppStyles.smallPadding), // AppStyles use kiya
                          Text(
                            _cityName!,
                            style: AppStyles.headlineStyle.copyWith(fontSize: 30), // AppStyles use kiya
                          ),
                          const SizedBox(height: AppStyles.smallPadding / 2),
                          Text(
                            "$_temperature°C",
                            style: AppStyles.headlineStyle.copyWith(fontSize: 48, fontWeight: FontWeight.w300, color: AppStyles.textColor), // AppStyles use kiya
                          ),
                          const SizedBox(height: AppStyles.defaultPadding), // AppStyles use kiya
                          Text(
                            _weatherDescription![0].toUpperCase() + _weatherDescription!.substring(1),
                            style: AppStyles.subTitleStyle.copyWith(fontStyle: FontStyle.italic, color: AppStyles.lightTextColor), // AppStyles use kiya
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
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