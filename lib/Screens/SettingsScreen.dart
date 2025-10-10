// lib/Screens/SettingsScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // File handling ke liye

import '../../Providers/AuthProvider.dart';
import '../../Utils/AppConstants.dart';
import '../../Utils/AppStyles.dart';


// Firebase imports
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider; 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Auth/LoginScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  File? _selectedImage; // Selected profile image file

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    _fullNameController = TextEditingController(text: user?.fullName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _uploadProfilePicture(); // Image select hotay hi upload kar dein
    }
  }

  Future<void> _uploadProfilePicture() async {
    if (_selectedImage == null) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userModel = authProvider.user; // Using userModel to avoid confusion with firebase.User

    if (userModel == null) {
      Fluttertoast.showToast(msg: "User not logged in.");
      return;
    }

    setState(() {
      authProvider.setLoading(true); // Loading state start
    });

    try {
      final storageRef = FirebaseStorage.instance.ref().child('profile_pictures').child('${userModel.uid}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      // Update Firestore user document with new image URL
      await FirebaseFirestore.instance.collection('users').doc(userModel.uid).update({
        'profileImageUrl': imageUrl,
      });

      // Update AuthProvider's user model
      authProvider.updateUserProfile(profileImageUrl: imageUrl);

      Fluttertoast.showToast(msg: "Profile picture updated successfully!");
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: "Failed to upload image: ${e.message}");
    } catch (e) {
      Fluttertoast.showToast(msg: "An unexpected error occurred: ${e.toString()}");
    } finally {
      setState(() {
        authProvider.setLoading(false); // Loading state end
      });
    }
  }


  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userModel = authProvider.user; // Using userModel to avoid confusion with firebase.User

      if (userModel == null) {
        Fluttertoast.showToast(msg: "User not logged in.");
        return;
      }

      setState(() {
        authProvider.setLoading(true); // Loading state start
      });

      try {
        String? newFullName = _fullNameController.text.trim();
        // Email update logic has been removed as per requirement

        // Update Full Name in Firestore if changed
        if (newFullName != userModel.fullName) {
          await FirebaseFirestore.instance.collection('users').doc(userModel.uid).update({
            'fullName': newFullName,
          });
          authProvider.updateUserProfile(fullName: newFullName);
          Fluttertoast.showToast(msg: "Full name updated successfully!");
        } else {
          Fluttertoast.showToast(msg: "No changes to update in profile.");
        }

      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: "Failed to update profile: ${e.message}");
      } catch (e) {
        Fluttertoast.showToast(msg: "An unexpected error occurred: ${e.toString()}");
      } finally {
        setState(() {
          authProvider.setLoading(false); // Loading state end
        });
      }
    }
  }


  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text != _confirmNewPasswordController.text) {
        Fluttertoast.showToast(msg: "New passwords do not match.");
        return;
      }

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userModel = authProvider.user;

      if (userModel == null) {
        Fluttertoast.showToast(msg: "User not logged in.");
        return;
      }

      setState(() {
        authProvider.setLoading(true);
      });

      try {
        User? firebaseUser = FirebaseAuth.instance.currentUser;
        if (firebaseUser == null) {
          Fluttertoast.showToast(msg: "No active Firebase user found.");
          return;
        }

        AuthCredential credential = EmailAuthProvider.credential(
          email: firebaseUser.email!, // Use the email from current Firebase user
          password: _currentPasswordController.text,
        );

        await firebaseUser.reauthenticateWithCredential(credential);
        await firebaseUser.updatePassword(_newPasswordController.text);

        Fluttertoast.showToast(msg: "Password updated successfully!");
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmNewPasswordController.clear();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: "Current password is incorrect.");
        } else if (e.code == 'requires-recent-login') {
          Fluttertoast.showToast(msg: "Please re-login to update your password.", toastLength: Toast.LENGTH_LONG);
        } else {
          Fluttertoast.showToast(msg: "Failed to update password: ${e.message}");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "An unexpected error occurred: ${e.toString()}");
      } finally {
        setState(() {
          authProvider.setLoading(false);
        });
      }
    }
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
    Fluttertoast.showToast(msg: "Logged out successfully!");
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.settingsDrawer),
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: AppStyles.whiteColor,
      ),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppStyles.primaryColor)))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppStyles.primaryColor.withOpacity(0.2),
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!) as ImageProvider
                          : (user?.profileImageUrl != null && user!.profileImageUrl!.isNotEmpty
                          ? NetworkImage(user.profileImageUrl!)
                          : null),
                      child: (user?.profileImageUrl == null || user!.profileImageUrl!.isEmpty) && _selectedImage == null
                          ? Text(
                        user?.fullName?.isNotEmpty == true
                            ? user!.fullName![0].toUpperCase()
                            : (user?.email?.isNotEmpty == true
                            ? user!.email![0].toUpperCase()
                            : 'U'),
                        style: AppStyles.headlineStyle.copyWith(color: AppStyles.primaryColor, fontSize: 40),
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: AppStyles.primaryColor, size: 28),
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

              // Profile Details Section
              Text(AppConstants.profileDetailsTitle, style: AppStyles.subTitleStyle),
              const SizedBox(height: AppStyles.defaultPadding),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: AppConstants.fullNameHint,
                  prefixIcon: Icon(Icons.person, color: AppStyles.primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppStyles.defaultPadding),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: AppConstants.emailHint,
                  prefixIcon: Icon(Icons.email, color: AppStyles.primaryColor),
                  // Style for disabled field hint if needed
                  // hintStyle: TextStyle(color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
                readOnly: true, // <--- Email field ko disable kar diya

              ),
              const SizedBox(height: AppStyles.largePadding),

              // Update Profile Button
              Center(
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  child: Text(AppConstants.updateProfileButtonText),
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

              // Change Password Section
              Text(AppConstants.changePasswordTitle, style: AppStyles.subTitleStyle),
              const SizedBox(height: AppStyles.defaultPadding),
              TextFormField(
                controller: _currentPasswordController,
                decoration: const InputDecoration(
                  labelText: AppConstants.currentPasswordHint,
                  prefixIcon: Icon(Icons.lock_outline, color: AppStyles.primaryColor),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppStyles.defaultPadding),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  labelText: AppConstants.newPasswordHint,
                  prefixIcon: Icon(Icons.lock, color: AppStyles.primaryColor),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppStyles.defaultPadding),
              TextFormField(
                controller: _confirmNewPasswordController,
                decoration: const InputDecoration(
                  labelText: AppConstants.confirmNewPasswordHint,


                  prefixIcon: Icon(Icons.lock_reset, color: AppStyles.primaryColor),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppStyles.largePadding),

              // Update Password Button
              Center(
                child: ElevatedButton(
                  onPressed: _updatePassword,
                  child: Text(AppConstants.updatePasswordButtonText),
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

              // Logout Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout, color: AppStyles.whiteColor),
                  label: Text(
                    AppConstants.logoutButtonText,
                    style: AppStyles.buttonTextStyle,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.errorColor,
                  ),
                ),
              ),
              const SizedBox(height: AppStyles.largePadding), // Extra space at bottom

              // Dark/Light Mode (will be added here later)
            ],
          ),
        ),
      ),
    );
  }
}

