// lib/Screens/ThemeSelectionScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/ThemeProvider.dart';
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Dynamic background
      appBar: AppBar(
        title: Text(AppConstants.themeSettingsTitle),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Dynamic AppBar background
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor, // Dynamic AppBar text/icon color
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        children: [
          // System Default Theme
          ListTile(
            title: Text(AppConstants.systemDefaultTheme, style: Theme.of(context).textTheme.bodyLarge),
            leading: const Icon(Icons.brightness_auto),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  themeProvider.setThemeMode(value);
                }
              },
            ),
            onTap: () => themeProvider.setThemeMode(ThemeMode.system),
          ),
          Divider(color: Theme.of(context).dividerColor),

          // Light Theme
          ListTile(
            title: Text(AppConstants.lightTheme, style: Theme.of(context).textTheme.bodyLarge),
            leading: const Icon(Icons.wb_sunny),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  themeProvider.setThemeMode(value);
                }
              },
            ),
            onTap: () => themeProvider.setThemeMode(ThemeMode.light),
          ),
          Divider(color: Theme.of(context).dividerColor),

          // Dark Theme
          ListTile(
            title: Text(AppConstants.darkTheme, style: Theme.of(context).textTheme.bodyLarge),
            leading: const Icon(Icons.nightlight_round),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  themeProvider.setThemeMode(value);
                }
              },
            ),
            onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}