// lib/Screens/HomeScreen.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Providers/AuthProvider.dart';
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import 'Auth/LoginScreen.dart';
import 'Chat/ChatScreen.dart';
import 'CropDiseaseDetectionScreen.dart';
// import 'FertilizerRecommendationScreen.dart'; // REMOVED: No longer needed for cards
// import 'MarketPriceScreen.dart'; // REMOVED: No longer needed for cards
import 'CropYieldPredictor.dart';
import 'SettingsScreen.dart';
import 'ThemeSelectionScreen.dart';
import 'WeatherScreen.dart';
import 'ContactUsScreen.dart'; // NEW: Import ContactUsScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // ✅ List of services (title, icon, screen)
  final List<Map<String, dynamic>> _services = [
    {
      "title": AppConstants.cropDiseaseDetection,
      "icon": Icons.pest_control,
      "screen": const CropDiseaseDetectionScreen(),
    },
    {
      "title": AppConstants.CropYieldForcaster,
      "icon": Icons.bar_chart, // Changed icon for Crop Yield Forecaster for better representation
      "screen": const CropYeildPridictor(),
    },
    {
      "title": AppConstants.weatherForecasting,
      "icon": Icons.cloud_queue,
      "screen": const WeatherScreen(),
    },
    // NEW SERVICE: Chat With Kisan AI
    {
      "title": AppConstants.chatWithKisanAI,
      "icon": Icons.chat_bubble_outline, // Chat icon
      "screen": const ChatScreen(),
    },
    // NEW SERVICE: Contact Us
    {
      "title": AppConstants.contactUs,
      "icon": Icons.contact_support, // Contact Us icon
      "screen": const ContactUsScreen(),
    },
    // REMOVED: Fertilizer Recommendation (was: AppConstants.fertilizerRecommendation, icon: Icons.science)
    // REMOVED: Market Price Prediction (was: AppConstants.marketPricePrediction, icon: Icons.attach_money)
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    // ✅ Filter services based on search text
    final filteredServices = _services.where((service) {
      final query = _searchController.text.toLowerCase();
      return service["title"].toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.appName),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.fullName ?? AppConstants.farmerUserName,
                  style: AppStyles.subTitleStyle.copyWith(color: AppStyles.whiteColor)),
              accountEmail: Text(user?.email ?? AppConstants.farmerUserEmail,
                  style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.whiteColor.withOpacity(0.8))),
              currentAccountPicture: CircleAvatar(
                radius: 40,
                backgroundColor: AppStyles.whiteColor,
                backgroundImage: (user?.profileImageUrl != null && user!.profileImageUrl!.isNotEmpty)
                    ? NetworkImage(user.profileImageUrl!) as ImageProvider<Object>?
                    : null,
                child: (user?.profileImageUrl == null || user!.profileImageUrl!.isEmpty)
                    ? Text(
                  user?.fullName?.isNotEmpty == true
                      ? user!.fullName![0].toUpperCase()
                      : (user?.email?.isNotEmpty == true
                      ? user!.email![0].toUpperCase()
                      : 'U'),
                  style: AppStyles.headlineStyle.copyWith(color: AppStyles.primaryColor, fontSize: 40),
                )
                    : null,
              ),
              decoration: const BoxDecoration(color: AppStyles.primaryColor),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: AppStyles.primaryColor),
              title: Text(AppConstants.homeDrawer, style: AppStyles.bodyTextStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: AppStyles.primaryColor),
              title: Text(AppConstants.settingsDrawer, style: AppStyles.bodyTextStyle),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.palette, color: Theme.of(context).iconTheme.color),
              title: Text(AppConstants.themeSettingsTitle, style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThemeSelectionScreen()),
                );
              },
            ),
            // NEW: Kisan AI Chat in Drawer
            ListTile(
              leading: const Icon(Icons.chat, color: AppStyles.primaryColor),
              title: Text(AppConstants.chatWithKisanAI, style: AppStyles.bodyTextStyle), // Using the new constant
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
            ),
            // NEW: Contact Us in Drawer
            ListTile(
              leading: const Icon(Icons.contact_support, color: AppStyles.primaryColor),
              title: Text(AppConstants.contactUs, style: AppStyles.bodyTextStyle), // Using the new constant
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: AppStyles.errorColor),
              title: Text(AppConstants.logoutDrawer,
                  style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.errorColor)),
              onTap: () async {
                Navigator.pop(context);
                await authProvider.logout();
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                );
                Fluttertoast.showToast(msg: "Logged out successfully!");
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Search Bar
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppConstants.searchHint,
                prefixIcon: const Icon(Icons.search, color: AppStyles.primaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: AppStyles.lightTextColor),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
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
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: AppStyles.largePadding),

            Text(AppConstants.ourServices, style: AppStyles.subTitleStyle),
            const SizedBox(height: AppStyles.defaultPadding),

            // ✅ GridView with filtered services
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppStyles.defaultPadding,
                mainAxisSpacing: AppStyles.defaultPadding,
                childAspectRatio: 1.0,
              ),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return _buildServiceCard(
                  context,
                  service["title"],
                  service["icon"],
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => service["screen"]),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: AppStyles.primaryColor),
              const SizedBox(height: AppStyles.smallPadding),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}