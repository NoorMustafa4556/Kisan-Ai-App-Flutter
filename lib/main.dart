// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Providers/AuthProvider.dart';
import 'Providers/ThemeProvider.dart';
import 'Screens/SplashScreen.dart';
import 'Utils/AppStyles.dart';

import 'firebase_options.dart'; // <--- Yeh line yahan add ki hai

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // ThemeProvider add
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Kisan AI Advisor',
            debugShowCheckedModeBanner: false,

            // Light Theme
            theme: ThemeData(
              primaryColor: AppStyles.primaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppStyles.primaryColor,
                brightness: Brightness.light,
              ),
              scaffoldBackgroundColor: Colors.grey[50],
              appBarTheme: AppBarTheme(
                backgroundColor: AppStyles.primaryColor,
                foregroundColor: AppStyles.whiteColor,
                elevation: 0,
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

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}