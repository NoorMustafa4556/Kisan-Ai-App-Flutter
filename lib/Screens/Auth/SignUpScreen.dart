// lib/Screens/Auth/SignupScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Providers/AuthProvider.dart';
import '../../Utils/AppConstants.dart';
import '../../Utils/AppStyles.dart';
import '../HomeScreen.dart';
import 'LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.signup(
        _fullNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (authProvider.errorMessage != null) {
        Fluttertoast.showToast(
          msg: authProvider.errorMessage!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
<<<<<<< HEAD
          backgroundColor: AppStyles.errorColor,
          textColor: AppStyles.whiteColor,
=======
          backgroundColor: Theme.of(context).colorScheme.error,
          textColor: Colors.white,
>>>>>>> b11e7d7 (first commit)
          fontSize: 16.0,
        );
        authProvider.clearErrorMessage();
      } else if (authProvider.user != null) {
        Fluttertoast.showToast(
          msg: "Signup Successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
<<<<<<< HEAD
          backgroundColor: AppStyles.primaryColor,
          textColor: AppStyles.whiteColor,
=======
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
>>>>>>> b11e7d7 (first commit)
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
<<<<<<< HEAD
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: AppStyles.backgroundColor,
=======
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: theme.scaffoldBackgroundColor,
>>>>>>> b11e7d7 (first commit)
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
                  AppConstants.signupTitle,
<<<<<<< HEAD
                  style: AppStyles.headlineStyle.copyWith(color: AppStyles.primaryColor),
=======
                  style: AppStyles.headlineStyle(context).copyWith(
                    color: theme.colorScheme.primary,
                  ),
>>>>>>> b11e7d7 (first commit)
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppStyles.largePadding),

<<<<<<< HEAD
                // Full Name Field
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    hintText: AppConstants.fullNameHint,
                    prefixIcon: Icon(Icons.person, color: AppStyles.primaryColor),
                  ),
=======
                // Full Name
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    hintText: AppConstants.fullNameHint,
                    prefixIcon: Icon(Icons.person, color: theme.colorScheme.primary),
                  ).applyDefaults(theme.inputDecorationTheme),
>>>>>>> b11e7d7 (first commit)
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppStyles.defaultPadding),

<<<<<<< HEAD
                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: AppConstants.emailHint,
                    prefixIcon: Icon(Icons.email, color: AppStyles.primaryColor),
                  ),
=======
                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: AppConstants.emailHint,
                    prefixIcon: Icon(Icons.email, color: theme.colorScheme.primary),
                  ).applyDefaults(theme.inputDecorationTheme),
>>>>>>> b11e7d7 (first commit)
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

<<<<<<< HEAD
                // Password Field
=======
                // Password
>>>>>>> b11e7d7 (first commit)
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: AppConstants.passwordHint,
<<<<<<< HEAD
                    prefixIcon: const Icon(Icons.lock, color: AppStyles.primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: AppStyles.primaryColor,
=======
                    prefixIcon: Icon(Icons.lock, color: theme.colorScheme.primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: theme.colorScheme.primary,
>>>>>>> b11e7d7 (first commit)
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
<<<<<<< HEAD
                  ),
=======
                  ).applyDefaults(theme.inputDecorationTheme),
>>>>>>> b11e7d7 (first commit)
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
                const SizedBox(height: AppStyles.defaultPadding),

<<<<<<< HEAD
                // Confirm Password Field
=======
                // Confirm Password
>>>>>>> b11e7d7 (first commit)
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: AppConstants.confirmPasswordHint,
<<<<<<< HEAD
                    prefixIcon: const Icon(Icons.lock_reset, color: AppStyles.primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppStyles.primaryColor,
=======
                    prefixIcon: Icon(Icons.lock_reset, color: theme.colorScheme.primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: theme.colorScheme.primary,
>>>>>>> b11e7d7 (first commit)
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
<<<<<<< HEAD
                  ),
=======
                  ).applyDefaults(theme.inputDecorationTheme),
>>>>>>> b11e7d7 (first commit)
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppStyles.largePadding),

                authProvider.isLoading
<<<<<<< HEAD
                    ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppStyles.primaryColor),
=======
                    ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
>>>>>>> b11e7d7 (first commit)
                  ),
                )
                    : ElevatedButton(
                  onPressed: _signup,
<<<<<<< HEAD
                  child: const Text(AppConstants.signupButtonText),
=======
                  child: Text(
                    AppConstants.signupButtonText,
                    style: AppStyles.buttonTextStyle(context),
                  ),
>>>>>>> b11e7d7 (first commit)
                ),
                const SizedBox(height: AppStyles.largePadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.alreadyAccountText,
<<<<<<< HEAD
                      style: AppStyles.bodyTextStyle,
=======
                      style: AppStyles.bodyTextStyle(context),
>>>>>>> b11e7d7 (first commit)
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        AppConstants.loginButtonText,
<<<<<<< HEAD
                        style: AppStyles.linkTextStyle,
=======
                        style: AppStyles.linkTextStyle(context),
>>>>>>> b11e7d7 (first commit)
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
<<<<<<< HEAD
}
=======
}
>>>>>>> b11e7d7 (first commit)
