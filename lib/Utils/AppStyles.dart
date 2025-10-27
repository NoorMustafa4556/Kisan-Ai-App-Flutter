// lib/Utils/AppStyles.dart

import 'package:flutter/material.dart';

class AppStyles {
  //  Spacing & Radius
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double smallPadding = 8.0;
  static const double defaultBorderRadius = 12.0;

  //  Colors
  static const Color primaryColor = Color(0xFF6B8E23);
  static const Color whiteColor = Colors.white;
  static const Color errorColor = Color(0xFFB00020);

  // Dynamic Styles

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
      color: whiteColor,
    );
  }

  //  Input Decoration
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
}