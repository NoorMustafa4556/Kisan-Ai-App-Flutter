// lib/Utils/AppStyles.dart - COMPLETE UPDATED CODE

import 'package:flutter/material.dart';

class AppStyles {
  // ------------------------- LIGHT THEME COLORS -------------------------
  static const Color primaryColor = Color(0xFF6B8E23); // Olive Green
  static const Color accentColor = Color(0xFFADD8E6); // Light Blue (example)
  static const Color backgroundColor = Color(0xFFF0F0F0); // Light Grey
  static const Color textColor = Color(0xFF333333); // Dark Grey
  static const Color lightTextColor = Color(0xFF666666);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color errorColor = Colors.red;

  // ------------------------- DARK THEME COLORS -------------------------
  // Aap in colors ko apni pasand ke mutabiq adjust kar sakte hain
  static const Color darkPrimaryColor = Color(0xFF8BC34A); // Lighter Green for dark theme
  static const Color darkAccentColor = Color(0xFF4FC3F7); // Lighter Blue for dark theme
  static const Color darkBackgroundColor = Color(0xFF121212); // Very Dark Grey
  static const Color darkTextColor = Color(0xFFE0E0E0); // Light Grey text
  static const Color darkLightTextColor = Color(0xFFAAAAAA); // Medium Grey text
  static const Color darkErrorColor = Color(0xFFEF5350); // Red for errors

  // ------------------------- TEXT STYLES (COMMON OR LIGHT THEME SPECIFIC) -------------------------
  static TextStyle headlineStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor, // Default for light theme, will be overridden by dark theme's TextTheme
  );

  // Naya headingTextStyle yahan add kiya gaya hai
  static TextStyle headingTextStyle = const TextStyle(
    fontSize: 22, // Example size, aap adjust kar sakte hain
    fontWeight: FontWeight.bold,
    color: textColor, // Default for light theme, will be overridden by dark theme's TextTheme
  );

  static TextStyle subTitleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor, // Default for light theme
  );

  static TextStyle bodyTextStyle = const TextStyle(
    fontSize: 16,
    color: textColor, // Default for light theme
  );

  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static TextStyle linkTextStyle = const TextStyle(
    fontSize: 14,
    color: primaryColor, // Default for light theme
    decoration: TextDecoration.underline,
  );

  static TextStyle smallTextStyle = const TextStyle(
    fontSize: 12,
    color: lightTextColor, // Default for light theme
  );

  static TextStyle appBarTitleTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  // ------------------------- INPUT FIELD DECORATIONS -------------------------
  // Light Theme Input Field Decoration
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: errorColor, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: errorColor, width: 2.0),
    ),
    hintStyle: TextStyle(color: Colors.grey[500]),
  );

  // Dark Theme Input Field Decoration (agar alag chahiye)
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[800], // Darker fill color
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: darkPrimaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: darkErrorColor, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: darkErrorColor, width: 2.0),
    ),
    hintStyle: TextStyle(color: Colors.grey[400]), // Lighter hint text
    labelStyle: const TextStyle(color: darkTextColor), // Label text color
  );


  // ------------------------- SPACING AND RADIUS -------------------------
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double smallPadding = 8.0;
  static const double defaultBorderRadius = 10.0;
}