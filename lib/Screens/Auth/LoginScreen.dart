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
<<<<<<< HEAD
      await authProvider.login(_emailController.text.trim(), _passwordController.text.trim());
=======
      await authProvider.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
>>>>>>> b11e7d7 (first commit)

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
          msg: "Login Successful!",
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
                  AppConstants.loginTitle,
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

                // Email field
                TextFormField(
                  controller: _emailController,
<<<<<<< HEAD
                  decoration: const InputDecoration(
                    hintText: AppConstants.emailHint,
                    prefixIcon: Icon(Icons.email, color: AppStyles.primaryColor),
                  ),
=======
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
                // Password field with eye icon
=======
                // Password field
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
                const SizedBox(height: AppStyles.smallPadding),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(msg: "Forgot Password Clicked!");
                    },
                    child: Text(
                      AppConstants.forgotPassword,
<<<<<<< HEAD
                      style: AppStyles.linkTextStyle,
=======
                      style: AppStyles.linkTextStyle(context),
>>>>>>> b11e7d7 (first commit)
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.defaultPadding),

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
                  onPressed: _login,
<<<<<<< HEAD
                  child: const Text(AppConstants.loginButtonText),
=======
                  child: Text(
                    AppConstants.loginButtonText,
                    style: AppStyles.buttonTextStyle(context),
                  ),
>>>>>>> b11e7d7 (first commit)
                ),
                const SizedBox(height: AppStyles.largePadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.noAccountText,
<<<<<<< HEAD
                      style: AppStyles.bodyTextStyle,
=======
                      style: AppStyles.bodyTextStyle(context),
>>>>>>> b11e7d7 (first commit)
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const SignupScreen()),
                        );
                      },
                      child: Text(
                        AppConstants.signupButtonText,
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
