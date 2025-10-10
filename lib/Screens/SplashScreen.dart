// lib/Screens/SplashScreen.dart

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart'; // <--- Provider ko import karein

import '../Providers/AuthProvider.dart'; // <--- AuthProvider ko import karein
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import 'Auth/LoginScreen.dart';
import 'HomeScreen.dart'; // <--- HomeScreen ko bhi import karein
=======
import 'package:provider/provider.dart';

import '../Providers/AuthProvider.dart';
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import 'Auth/LoginScreen.dart';
import 'HomeScreen.dart';
>>>>>>> b11e7d7 (first commit)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _checkAuthStatus(); // <--- Naya method call karein
  }

  Future<void> _checkAuthStatus() async {
    // Thodi der wait karein ताकि splash screen dikhayi de
    await Future.delayed(const Duration(seconds: 3));

    // AuthProvider ko fetch karein (listen: false kyunki hum sirf action kar rahe hain)
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkUserSession(); // User session check karein

    if (!mounted) return; // Widget dispose ho gaya ho to aage na badhein

    // Session check ke baad, user logged in hai ya nahi uske mutabiq navigate karein
    if (authProvider.user != null) {
      // User logged in hai, HomeScreen par jaayega
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // User logged in nahi hai, LoginScreen par jaayega
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
=======
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkUserSession();

    if (!mounted) return;

    if (authProvider.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
>>>>>>> b11e7d7 (first commit)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: AppStyles.primaryColor, // Splash screen ka background color
=======
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary, // Dynamic primary color
>>>>>>> b11e7d7 (first commit)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< HEAD
            // App ka logo yahan aayega
            // Abhi ke liye ek simple Icon ya Text
            // Aap apni image bhi yahan use kar sakte hain: Image.asset('assets/images/logo.png')
            const Icon(
              Icons.agriculture, // Example icon
              size: 100,
              color: AppStyles.whiteColor,
            ),
            const SizedBox(height: 20),
            Text(
              AppConstants.appName,
              style: AppStyles.headlineStyle.copyWith(color: AppStyles.whiteColor),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppStyles.whiteColor),
=======
            // App Logo
            Icon(
              Icons.agriculture,
              size: 100,
              color: Colors.white, // White for contrast on primary background
            ),
            const SizedBox(height: 20),

            // App Name
            Text(
              AppConstants.appName,
              style: AppStyles.headlineStyle(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Loading Indicator
            CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
>>>>>>> b11e7d7 (first commit)
            ),
          ],
        ),
      ),
    );
  }
}