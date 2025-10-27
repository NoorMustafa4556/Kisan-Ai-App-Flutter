import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  File? _selectedImage;

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
      _uploadProfilePicture();
    }
  }

  Future<void> _uploadProfilePicture() async {
    if (_selectedImage == null) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userModel = authProvider.user;

    if (userModel == null) {
      Fluttertoast.showToast(
        msg: "User not logged in.",
        backgroundColor: Theme.of(context).colorScheme.error,
        textColor: Colors.white,
      );
      return;
    }

    authProvider.setLoading(true);

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${userModel.uid}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .update({'profileImageUrl': imageUrl});

      authProvider.updateUserProfile(profileImageUrl: imageUrl);

      Fluttertoast.showToast(
        msg: "Profile picture updated successfully!",
        backgroundColor: AppStyles.primaryColor, // ✅ replaced here
        textColor: Colors.white,
      );
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to upload image: ${e.message}",
        backgroundColor: Theme.of(context).colorScheme.error,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: Theme.of(context).colorScheme.error,
        textColor: Colors.white,
      );
    } finally {
      if (mounted) {
        authProvider.setLoading(false);
      }
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userModel = authProvider.user;

    if (userModel == null) {
      Fluttertoast.showToast(msg: "User not logged in.");
      return;
    }

    authProvider.setLoading(true);

    try {
      final newFullName = _fullNameController.text.trim();

      if (newFullName != userModel.fullName) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.uid)
            .update({'fullName': newFullName});

        authProvider.updateUserProfile(fullName: newFullName);
        Fluttertoast.showToast(msg: "Full name updated successfully!");
      } else {
        Fluttertoast.showToast(msg: "No changes to update.");
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: "Failed: ${e.message}");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      if (mounted) authProvider.setLoading(false);
    }
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

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

    authProvider.setLoading(true);

    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        Fluttertoast.showToast(msg: "No active user found.");
        return;
      }

      final credential = EmailAuthProvider.credential(
        email: firebaseUser.email!,
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
        Fluttertoast.showToast(msg: "Please re-login to update password.", toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(msg: "Failed: ${e.message}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      if (mounted) authProvider.setLoading(false);
    }
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );

    Fluttertoast.showToast(
      msg: "Logged out successfully!",
      backgroundColor: AppStyles.primaryColor, // ✅ replaced here
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.settingsDrawer, style: AppStyles.appBarTitleStyle(context)),
        backgroundColor: AppStyles.primaryColor, // ✅ replaced here
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: authProvider.isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppStyles.primaryColor), // ✅ replaced here
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppStyles.primaryColor.withOpacity(0.15), // ✅ replaced here
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : (user?.profileImageUrl?.isNotEmpty ?? false)
                          ? NetworkImage(user!.profileImageUrl!)
                          : null,
                      child: (_selectedImage == null && (user?.profileImageUrl?.isEmpty ?? true))
                          ? Text(
                        (user?.fullName?.isNotEmpty == true
                            ? user!.fullName![0]
                            : user?.email?.isNotEmpty == true
                            ? user!.email![0]
                            : 'U')
                            .toUpperCase(),
                        style: AppStyles.headlineStyle(context).copyWith(
                          color: AppStyles.primaryColor, // ✅ replaced here
                          fontSize: 40,
                        ),
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppStyles.primaryColor, // ✅ replaced here
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

              // Profile Details
              Text(AppConstants.profileDetailsTitle, style: AppStyles.subTitleStyle(context)),
              const SizedBox(height: AppStyles.defaultPadding),
              _buildTextField(
                controller: _fullNameController,
                label: AppConstants.fullNameHint,
                icon: Icons.person,
                validator: (v) => v?.isEmpty ?? true ? 'Enter full name' : null,
              ),
              const SizedBox(height: AppStyles.defaultPadding),
              _buildTextField(
                controller: _emailController,
                label: AppConstants.emailHint,
                icon: Icons.email,
                readOnly: true,
              ),
              const SizedBox(height: AppStyles.largePadding),

              Center(
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primaryColor, // ✅ replaced here
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(AppConstants.updateProfileButtonText, style: AppStyles.buttonTextStyle(context)),
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

              // Change Password
              Text(AppConstants.changePasswordTitle, style: AppStyles.subTitleStyle(context)),
              const SizedBox(height: AppStyles.defaultPadding),
              _buildTextField(
                controller: _currentPasswordController,
                label: AppConstants.currentPasswordHint,
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (v) => v?.isEmpty ?? true ? 'Enter current password' : null,
              ),
              const SizedBox(height: AppStyles.defaultPadding),
              _buildTextField(
                controller: _newPasswordController,
                label: AppConstants.newPasswordHint,
                icon: Icons.lock,
                obscureText: true,
                validator: (v) {
                  if (v?.isEmpty ?? true) return 'Enter new password';
                  if (v!.length < 6) return 'Min 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: AppStyles.defaultPadding),
              _buildTextField(
                controller: _confirmNewPasswordController,
                label: AppConstants.confirmNewPasswordHint,
                icon: Icons.lock_reset,
                obscureText: true,
                validator: (v) => v != _newPasswordController.text ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: AppStyles.largePadding),

              Center(
                child: ElevatedButton(
                  onPressed: _updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primaryColor, // ✅ replaced here
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(AppConstants.updatePasswordButtonText, style: AppStyles.buttonTextStyle(context)),
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

              // Logout
              Center(
                child: ElevatedButton.icon(
                  onPressed: _logout,
                  icon: const Icon(Icons.logout),
                  label: Text(AppConstants.logoutButtonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppStyles.primaryColor), // ✅ replaced here
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          borderSide: BorderSide(color: AppStyles.primaryColor, width: 2), // ✅ replaced here
        ),
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: validator,
    );
  }
}
