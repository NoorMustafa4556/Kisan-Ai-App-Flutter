// lib/Screens/SplashScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <--- Provider ko import karein

import '../Providers/AuthProvider.dart'; // <--- AuthProvider ko import karein
import '../Utils/AppConstants.dart';
import '../Utils/AppStyles.dart';
import 'Auth/LoginScreen.dart';
import 'HomeScreen.dart'; // <--- HomeScreen ko bhi import karein

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryColor, // Splash screen ka background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ),
          ],
        ),
      ),
    );
  }
}