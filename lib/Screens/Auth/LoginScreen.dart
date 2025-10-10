// lib/Screens/Auth/LoginScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Providers/AuthProvider.dart';
import '../../Utils/AppConstants.dart';
import '../../Utils/AppStyles.dart';
import '../HomeScreen.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.login(_emailController.text.trim(), _passwordController.text.trim());

      if (!mounted) return;

      if (authProvider.errorMessage != null) {
        Fluttertoast.showToast(
          msg: authProvider.errorMessage!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppStyles.errorColor,
          textColor: AppStyles.whiteColor,
          fontSize: 16.0,
        );
        authProvider.clearErrorMessage();
      } else if (authProvider.user != null) {
        Fluttertoast.showToast(
          msg: "Login Successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppStyles.primaryColor,
          textColor: AppStyles.whiteColor,
          fontSize: 16.0,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: AppStyles.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppConstants.loginTitle,
                  style: AppStyles.headlineStyle.copyWith(color: AppStyles.primaryColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppStyles.largePadding),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: AppConstants.emailHint,
                    prefixIcon: Icon(Icons.email, color: AppStyles.primaryColor),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppStyles.defaultPadding),

                // Password field with eye icon
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: AppConstants.passwordHint,
                    prefixIcon: const Icon(Icons.lock, color: AppStyles.primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppStyles.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppStyles.smallPadding),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(msg: "Forgot Password Clicked!");
                    },
                    child: Text(
                      AppConstants.forgotPassword,
                      style: AppStyles.linkTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.defaultPadding),

                authProvider.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppStyles.primaryColor),
                  ),
                )
                    : ElevatedButton(
                  onPressed: _login,
                  child: const Text(AppConstants.loginButtonText),
                ),
                const SizedBox(height: AppStyles.largePadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.noAccountText,
                      style: AppStyles.bodyTextStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const SignupScreen()),
                        );
                      },
                      child: Text(
                        AppConstants.signupButtonText,
                        style: AppStyles.linkTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
