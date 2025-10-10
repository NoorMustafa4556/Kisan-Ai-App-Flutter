// lib/Screens/SettingsScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< HEAD
import 'dart:io'; // File handling ke liye
=======
import 'dart:io';
>>>>>>> b11e7d7 (first commit)

import '../../Providers/AuthProvider.dart';
import '../../Utils/AppConstants.dart';
import '../../Utils/AppStyles.dart';

<<<<<<< HEAD

// Firebase imports
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider; 
=======
// Firebase imports
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
>>>>>>> b11e7d7 (first commit)
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

<<<<<<< HEAD
  File? _selectedImage; // Selected profile image file
=======
  File? _selectedImage;
>>>>>>> b11e7d7 (first commit)

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
<<<<<<< HEAD
      _uploadProfilePicture(); // Image select hotay hi upload kar dein
=======
      _uploadProfilePicture();
>>>>>>> b11e7d7 (first commit)
    }
  }

  Future<void> _uploadProfilePicture() async {
    if (_selectedImage == null) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
<<<<<<< HEAD
    final userModel = authProvider.user; // Using userModel to avoid confusion with firebase.User
=======
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
        backgroundColor: Theme.of(context).colorScheme.primary,
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
>>>>>>> b11e7d7 (first commit)

    if (userModel == null) {
      Fluttertoast.showToast(msg: "User not logged in.");
      return;
    }

<<<<<<< HEAD
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
=======
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
>>>>>>> b11e7d7 (first commit)
    }
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (!mounted) return;
<<<<<<< HEAD
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
    Fluttertoast.showToast(msg: "Logged out successfully!");
=======

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );

    Fluttertoast.showToast(
      msg: "Logged out successfully!",
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
    );
>>>>>>> b11e7d7 (first commit)
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    final theme = Theme.of(context);
>>>>>>> b11e7d7 (first commit)
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
<<<<<<< HEAD
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.settingsDrawer),
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: AppStyles.whiteColor,
      ),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppStyles.primaryColor)))
=======
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.settingsDrawer, style: AppStyles.appBarTitleStyle(context)),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: authProvider.isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
        ),
      )
>>>>>>> b11e7d7 (first commit)
          : SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              // Profile Picture Section
=======
              // Profile Picture
>>>>>>> b11e7d7 (first commit)
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
<<<<<<< HEAD
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
=======
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
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
                          color: theme.colorScheme.primary,
                          fontSize: 40,
                        ),
>>>>>>> b11e7d7 (first commit)
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
<<<<<<< HEAD
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: AppStyles.primaryColor, size: 28),
                        onPressed: _pickImage,
=======
                      child: InkWell(
                        onTap: _pickImage,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
>>>>>>> b11e7d7 (first commit)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

<<<<<<< HEAD
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
=======
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
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(AppConstants.updateProfileButtonText, style: AppStyles.buttonTextStyle(context)),
>>>>>>> b11e7d7 (first commit)
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

<<<<<<< HEAD
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
=======
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
>>>>>>> b11e7d7 (first commit)
                  return null;
                },
              ),
              const SizedBox(height: AppStyles.defaultPadding),
<<<<<<< HEAD
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
=======
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
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(AppConstants.updatePasswordButtonText, style: AppStyles.buttonTextStyle(context)),
>>>>>>> b11e7d7 (first commit)
                ),
              ),
              const SizedBox(height: AppStyles.largePadding),

<<<<<<< HEAD
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
=======
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
>>>>>>> b11e7d7 (first commit)
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}

=======

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: theme.colorScheme.primary),
        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      ).applyDefaults(theme.inputDecorationTheme),
      validator: validator,
    );
  }
}
>>>>>>> b11e7d7 (first commit)
