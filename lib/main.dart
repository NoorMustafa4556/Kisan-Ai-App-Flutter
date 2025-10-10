import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'Providers/AuthProvider.dart';
import 'Providers/ThemeProvider.dart'; // <--- Naya import
import 'Screens/SplashScreen.dart';
import 'Utils/AppStyles.dart';

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
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // <--- ThemeProvider add kiya
      ],
      child: Consumer<ThemeProvider>( // <--- Consumer se ThemeProvider ko listen karenge
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Kisan AI Advisor',
            debugShowCheckedModeBanner: false,
            // ThemeProvider se theme mode set karenge
            themeMode: themeProvider.themeMode, // <--- Theme mode set kiya
            theme: ThemeData( // Light Theme
              primaryColor: AppStyles.primaryColor,
              hintColor: AppStyles.accentColor,
              scaffoldBackgroundColor: AppStyles.backgroundColor,
              appBarTheme: AppBarTheme(
                backgroundColor: AppStyles.primaryColor,
                foregroundColor: AppStyles.whiteColor,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: AppStyles.appBarTitleTextStyle,
              ),
              inputDecorationTheme: AppStyles.inputDecorationTheme,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  foregroundColor: AppStyles.whiteColor,
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
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}