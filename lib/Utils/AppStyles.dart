<<<<<<< HEAD
// lib/Utils/AppStyles.dart - COMPLETE UPDATED CODE
=======
// lib/Utils/AppStyles.dart
>>>>>>> b11e7d7 (first commit)

import 'package:flutter/material.dart';

class AppStyles {
<<<<<<< HEAD
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
=======
  // ------------------------- SPACING & RADIUS (Safe to keep static) -------------------------
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double smallPadding = 8.0;
  static const double defaultBorderRadius = 12.0;

  // ------------------------- FIXED PAKISTAN GREEN (Never changes) -------------------------
  static const Color primaryColor = Color(0xFF6b8e23); // Original Pakistan Green
  static const Color whiteColor = Colors.white;
  static const Color errorColor = Color(0xFFB00020);

  // ------------------------- DYNAMIC STYLES (Theme-safe, but primary fixed) -------------------------

  static TextStyle headlineStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      color: primaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headingTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      color: primaryColor,
    );
  }

  static TextStyle subTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      color: primaryColor,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bodyTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.85),
    );
  }

  static TextStyle buttonTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontWeight: FontWeight.bold,
      color: whiteColor, // Buttons always white on green
    );
  }

  static TextStyle linkTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: primaryColor,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle smallTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
    );
  }

  static TextStyle appBarTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: whiteColor, // AppBar title always white
    );
  }

  // ------------------------- INPUT DECORATION (Theme-safe, but primary fixed) -------------------------
  static InputDecorationTheme inputDecorationTheme(BuildContext context) {
    final theme = Theme.of(context);
    return InputDecorationTheme(
      filled: true,
      fillColor: theme.brightness == Brightness.light
          ? Colors.grey[100]
          : Colors.grey[800],
      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: BorderSide(color: primaryColor, width: 2.0), // Fixed Green
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      hintStyle: TextStyle(color: theme.hintColor),
      labelStyle: TextStyle(color: primaryColor), // Labels in green
    );
  }
>>>>>>> b11e7d7 (first commit)
}