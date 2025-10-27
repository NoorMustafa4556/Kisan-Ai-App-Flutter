import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String _apiKey = "d3efac31381a742f9e56142eb96c2341";

  final TextEditingController _cityController = TextEditingController();

  String? _cityName;
  String? _temperature;
  String? _weatherDescription;
  String? _weatherIcon;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _citySuggestions = [
    "Karachi", "Lahore", "Islamabad", "Rawalpindi", "Faisalabad", "Multan", "Peshawar",
    "Quetta", "Gujranwala", "Sialkot", "Hyderabad", "Sargodha", "Bahawalpur", "Sukkur",
    "Sheikhupura", "Mardan", "Gujrat", "Kasur", "Sahiwal", "Okara",
    "Vehari", "Khanewal", "Jhelum", "Muzaffargarh", "Khushab",
    "Chiniot", "Jhang", "Bahawalnagar", "Mandi Bahauddin", "Hafizabad", "Narowal",
    "Toba Tek Singh", "Pakpattan", "Chakwal", "Mianwali", "Layyah", "Bhakkar", "Dera Ghazi Khan",
    "Lodhran", "Burewala", "Kamalia", "Arifwala", "Chishtian", "Sadiqabad", "Kamoke",
    "Gujar Khan", "Murree", "Pattoki", "Raiwind", "Dera Ismail Khan", "Karak", "Bannu",
    "Chaman", "Mirpur", "Kotli", "Muzaffarabad", "Skardu", "Gilgit", "Khairpur",
    "Jacobabad", "Shikarpur", "Umerkot", "Nawabshah", "Larkana", "Mithi", "Dadu",
    "Badin", "Tando Adam", "Tando Allahyar", "Kot Addu", "Hangu", "Tank", "Chitral",
    "Dir", "Swabi", "Haripur", "Abbottabad", "Mansehra", "Battagram",
    "Zhob", "Kalat", "Turbat", "Gwadar", "Nushki", "Sibi", "Dera Bugti",
    "Jiwani", "Harnai", "Khuzdar", "Nawabshah", "Ahmedpur"
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
        _temperature = null;
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
      _filteredSuggestions = [];
    });

    final String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric";

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
        String message = data['message'] ?? "City not found.";
        setState(() => _errorMessage = message[0].toUpperCase() + message.substring(1));
      }
    } catch (e) {
      setState(() => _errorMessage = "Failed to load weather data. Check your connection.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.weatherForecasting, style: AppStyles.appBarTitleStyle(context)),
        backgroundColor: AppStyles.primaryColor, // ✅ replaced here
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppStyles.primaryColor.withOpacity(0.7), // ✅ replaced here
              AppStyles.primaryColor.withOpacity(0.9), // ✅ replaced here
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppStyles.defaultPadding,
            AppStyles.defaultPadding,
            AppStyles.defaultPadding,
            0,
          ),
          child: Column(
            children: [
              // Search Field
              Stack(
                children: [
                  TextField(
                    controller: _cityController,
                    style: AppStyles.bodyTextStyle(context),
                    decoration: InputDecoration(
                      labelText: "Enter City Name",
                      labelStyle: AppStyles.bodyTextStyle(context).copyWith(
                        color: Colors.white70,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                      ),
                      prefixIcon: const Icon(Icons.location_city, color: Colors.white),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          _fetchWeather(_cityController.text.trim());
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ).applyDefaults(theme.inputDecorationTheme),
                    onChanged: _updateSuggestions,
                    onSubmitted: (value) {
                      _fetchWeather(value.trim());
                      FocusScope.of(context).unfocus();
                    },
                  ),

                  // Suggestions
                  if (_filteredSuggestions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 65.0),
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                        ),
                        color: theme.cardColor,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 220),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _filteredSuggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion = _filteredSuggestions[index];
                              return ListTile(
                                title: Text(suggestion, style: AppStyles.bodyTextStyle(context)),
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
                    ),
                ],
              ),

              const SizedBox(height: AppStyles.defaultPadding),

              // Weather Display
              Expanded(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : _errorMessage != null
                      ? Text(
                    _errorMessage!,
                    style: AppStyles.bodyTextStyle(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                      : _cityName == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wb_cloudy_outlined, size: 80, color: Colors.white),
                      const SizedBox(height: AppStyles.defaultPadding),
                      Text(
                        "Search for a city to see the weather",
                        style: AppStyles.bodyTextStyle(context).copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                      : Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius * 2),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(AppStyles.largePadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_weatherIcon != null)
                            Image.network(
                              "https://openweathermap.org/img/wn/$_weatherIcon@4x.png",
                              width: 120,
                              height: 120,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.cloud_off,
                                size: 80,
                                color: theme.hintColor,
                              ),
                            ),
                          const SizedBox(height: AppStyles.smallPadding),
                          Text(
                            _cityName!,
                            style: AppStyles.headlineStyle(context).copyWith(fontSize: 30),
                          ),
                          const SizedBox(height: AppStyles.smallPadding / 2),
                          Text(
                            "$_temperature°C",
                            style: AppStyles.headlineStyle(context).copyWith(
                              fontSize: 48,
                              fontWeight: FontWeight.w300,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppStyles.defaultPadding),
                          Text(
                            _weatherDescription![0].toUpperCase() +
                                _weatherDescription!.substring(1),
                            style: AppStyles.subTitleStyle(context).copyWith(
                              fontStyle: FontStyle.italic,
                              color: theme.hintColor,
                            ),
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
