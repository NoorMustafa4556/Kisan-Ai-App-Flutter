import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Providers/AuthProvider.dart';
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import 'Auth/LoginScreen.dart';
import 'Chat/ChatScreen.dart';
import 'CropDiseaseDetectionScreen.dart';
import 'CropYieldPredictor.dart';
import 'SettingsScreen.dart';
import 'ThemeSelectionScreen.dart';
import 'WeatherScreen.dart';
import 'ContactUsScreen.dart';
import 'DistrictYieldForecastingScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // ✅ Updated service list
  final List<Map<String, dynamic>> _services = [
    {
      "title": AppConstants.cropDiseaseDetection,
      "icon": Icons.pest_control,
      "screen": const CropDiseaseDetectionScreen(),
    },
    {
      "title": AppConstants.CropYieldForcaster,
      "icon": Icons.bar_chart,
      "screen": const CropYeildPridictor(),
    },
    {
      "title": AppConstants.weatherForecasting,
      "icon": Icons.cloud_queue,
      "screen": const WeatherScreen(),
    },
    {
      "title": "District Yield Forecasting",
      "icon": Icons.agriculture,
      "screen": const DistrictYieldForecastingScreen(),
    },
    {
      "title": AppConstants.chatWithKisanAI,
      "icon": Icons.chat_bubble_outline,
      "screen": const ChatScreen(),
    },
    {
      "title": AppConstants.contactUs,
      "icon": Icons.contact_support,
      "screen": const ContactUsScreen(),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    final filteredServices = _services.where((service) {
      final query = _searchController.text.toLowerCase();
      return service["title"].toString().toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.appName, style: AppStyles.appBarTitleStyle(context)),
        backgroundColor: AppStyles.primaryColor, // ✅ replaced
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user?.fullName ?? AppConstants.farmerUserName,
                style: AppStyles.subTitleStyle(context).copyWith(color: Colors.white),
              ),
              accountEmail: Text(
                user?.email ?? AppConstants.farmerUserEmail,
                style: AppStyles.bodyTextStyle(context).copyWith(color: Colors.white.withOpacity(0.8)),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: (user?.profileImageUrl?.isNotEmpty ?? false)
                    ? NetworkImage(user!.profileImageUrl!)
                    : null,
                child: (user?.profileImageUrl?.isEmpty ?? true)
                    ? Text(
                  (user?.fullName?.isNotEmpty == true
                      ? user!.fullName![0]
                      : user?.email?.isNotEmpty == true
                      ? user!.email![0]
                      : 'U')
                      .toUpperCase(),
                  style: AppStyles.headlineStyle(context).copyWith(
                    color: AppStyles.primaryColor, // ✅ replaced
                    fontSize: 40,
                  ),
                )
                    : null,
              ),
              decoration: BoxDecoration(color: AppStyles.primaryColor), // ✅ replaced
            ),
            ListTile(
              leading: Icon(Icons.home, color: AppStyles.primaryColor), // ✅ replaced
              title: Text(AppConstants.homeDrawer, style: AppStyles.bodyTextStyle(context)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: AppStyles.primaryColor), // ✅ replaced
              title: Text(AppConstants.settingsDrawer, style: AppStyles.bodyTextStyle(context)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.palette, color: AppStyles.primaryColor), // ✅ replaced
              title: Text(AppConstants.themeSettingsTitle, style: theme.textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ThemeSelectionScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.chat, color: AppStyles.primaryColor), // ✅ replaced
              title: Text(AppConstants.chatWithKisanAI, style: AppStyles.bodyTextStyle(context)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support, color: AppStyles.primaryColor), // ✅ replaced
              title: Text(AppConstants.contactUs, style: AppStyles.bodyTextStyle(context)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: theme.colorScheme.error),
              title: Text(
                AppConstants.logoutDrawer,
                style: AppStyles.bodyTextStyle(context).copyWith(color: theme.colorScheme.error),
              ),
              onTap: () async {
                Navigator.pop(context);
                await authProvider.logout();
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
                Fluttertoast.showToast(
                  msg: "Logged out successfully!",
                  backgroundColor: AppStyles.primaryColor, // ✅ replaced
                  textColor: Colors.white,
                );
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
            // 🔍 Search Bar
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppConstants.searchHint,
                prefixIcon: Icon(Icons.search, color: AppStyles.primaryColor), // ✅ replaced
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear, color: theme.hintColor),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
                    : null,
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  borderSide: BorderSide(color: AppStyles.primaryColor, width: 2), // ✅ replaced
                ),
              ).applyDefaults(theme.inputDecorationTheme),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppStyles.largePadding),

            // 🌾 Services Grid
            Text(AppConstants.ourServices, style: AppStyles.subTitleStyle(context)),
            const SizedBox(height: AppStyles.defaultPadding),

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
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => service["screen"]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🌾 Unified Card Design
  Widget _buildServiceCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius)),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: AppStyles.primaryColor), // ✅ replaced
              const SizedBox(height: AppStyles.smallPadding),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyles.bodyTextStyle(context).copyWith(fontWeight: FontWeight.w600),
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
