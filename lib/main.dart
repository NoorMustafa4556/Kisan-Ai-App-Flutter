<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'Providers/AuthProvider.dart';
import 'Providers/ThemeProvider.dart'; // <--- Naya import
=======
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Providers/AuthProvider.dart';
import 'Providers/ThemeProvider.dart'; // Yeh import add kiya
>>>>>>> b11e7d7 (first commit)
import 'Screens/SplashScreen.dart';
import 'Utils/AppStyles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
=======
  await Firebase.initializeApp();

>>>>>>> b11e7d7 (first commit)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
<<<<<<< HEAD
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // <--- ThemeProvider add kiya
      ],
      child: Consumer<ThemeProvider>( // <--- Consumer se ThemeProvider ko listen karenge
=======
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // ThemeProvider add
      ],
      child: Consumer<ThemeProvider>(
>>>>>>> b11e7d7 (first commit)
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Kisan AI Advisor',
            debugShowCheckedModeBanner: false,
<<<<<<< HEAD
            // ThemeProvider se theme mode set karenge
            themeMode: themeProvider.themeMode, // <--- Theme mode set kiya
            theme: ThemeData( // Light Theme
              primaryColor: AppStyles.primaryColor,
              hintColor: AppStyles.accentColor,
              scaffoldBackgroundColor: AppStyles.backgroundColor,
=======

            // Light Theme
            theme: ThemeData(
              primaryColor: AppStyles.primaryColor, // 6B8E23
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppStyles.primaryColor,
                brightness: Brightness.light,
              ),
              scaffoldBackgroundColor: Colors.grey[50],
>>>>>>> b11e7d7 (first commit)
              appBarTheme: AppBarTheme(
                backgroundColor: AppStyles.primaryColor,
                foregroundColor: AppStyles.whiteColor,
                elevation: 0,
<<<<<<< HEAD
                centerTitle: true,
                titleTextStyle: AppStyles.appBarTitleTextStyle,
              ),
              inputDecorationTheme: AppStyles.inputDecorationTheme,
=======
              ),
>>>>>>> b11e7d7 (first commit)
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  foregroundColor: AppStyles.whiteColor,
<<<<<<< HEAD
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: AppStyles.buttonTextStyle,
                ),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: AppStyles.textColor),
                bodyMedium: TextStyle(color: AppStyles.textColor),
              ),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: AppStyles.accentColor,
                primary: AppStyles.primaryColor,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData( // <--- Dark Theme add kiya
              brightness: Brightness.dark,
              primaryColor: AppStyles.darkPrimaryColor, // Aap AppStyles mein define kar sakte hain
              hintColor: AppStyles.darkAccentColor,   // Aap AppStyles mein define kar sakte hain
              scaffoldBackgroundColor: AppStyles.darkBackgroundColor, // Aap AppStyles mein define kar sakte hain
              appBarTheme: AppBarTheme(
                backgroundColor: AppStyles.darkPrimaryColor,
                foregroundColor: AppStyles.whiteColor,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: AppStyles.appBarTitleTextStyle, // Dark theme ke liye bhi yahi style use kar sakte hain ya change kar sakte hain
              ),
              inputDecorationTheme: AppStyles.darkInputDecorationTheme, // Aap AppStyles mein define kar sakte hain
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.darkPrimaryColor,
                  foregroundColor: AppStyles.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: AppStyles.buttonTextStyle,
                ),
              ),
              textTheme: TextTheme(
                bodyLarge: const TextStyle(color: AppStyles.darkTextColor),
                bodyMedium: TextStyle(color: AppStyles.darkTextColor),
              ),
              colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
                secondary: AppStyles.darkAccentColor,
                primary: AppStyles.darkPrimaryColor,
              ),
              useMaterial3: true,
            ),
=======
                ),
              ),
              inputDecorationTheme: AppStyles.inputDecorationTheme(context),
              useMaterial3: true,
            ),

            // Dark Theme
            darkTheme: ThemeData(
              primaryColor: AppStyles.primaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppStyles.primaryColor,
                brightness: Brightness.dark,
              ),
              scaffoldBackgroundColor: Colors.grey[900],
              appBarTheme: AppBarTheme(
                backgroundColor: AppStyles.primaryColor,
                foregroundColor: AppStyles.whiteColor,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  foregroundColor: AppStyles.whiteColor,
                ),
              ),
              inputDecorationTheme: AppStyles.inputDecorationTheme(context),
              useMaterial3: true,
            ),

            // Yeh line add ki → ThemeProvider se mode le
            themeMode: themeProvider.themeMode,

>>>>>>> b11e7d7 (first commit)
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}