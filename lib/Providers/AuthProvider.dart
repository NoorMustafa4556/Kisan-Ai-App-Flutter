// lib/Providers/AuthProvider.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // DocumentSnapshot ke liye
import '../Models/UserModel.dart';
import '../Services/Auth/AuthService.dart'; // AuthService ko import karein

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService(); // AuthService ka instance banayein

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Login method ko update karein takay AuthService use kare
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null; // Purana error message clear karein
    notifyListeners();

    try {
      _user = await _authService.signInWithEmailAndPassword(email, password);
      print("AuthProvider: Login successful for: ${_user?.email}");
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      print("AuthProvider: Login failed: $e");
      _user = null; // Agar login fail ho to user ko null set karein
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Signup method ko update karein takay AuthService use kare
  Future<void> signup(String fullName, String email, String password) async {
    _isLoading = true;
    _errorMessage = null; // Purana error message clear karein
    notifyListeners();

    try {
      _user = await _authService.signUpWithEmailAndPassword(fullName, email, password);
      print("AuthProvider: Signup successful for: ${_user?.email}");
    } catch (e) {
      _errorMessage = 'Signup failed: ${e.toString()}';
      print("AuthProvider: Signup failed: $e");
      _user = null; // Agar signup fail ho to user ko null set karein
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout method ko update karein takay AuthService use kare
  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signOut();
      _user = null; // User ko null karein
      print("AuthProvider: User logged out.");
    } catch (e) {
      _errorMessage = 'Logout failed: ${e.toString()}';
      print("AuthProvider: Logout failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // User session check method ko update karein takay AuthService ke getters use kare
  Future<void> checkUserSession() async {
    _isLoading = true;
    notifyListeners();

    try {
      // AuthService ke public getters ko use kar ke current Firebase user check karein
      if (_authService.firebaseAuth.currentUser != null) {
        String uid = _authService.firebaseAuth.currentUser!.uid;
        // AuthService ke public getter 'firestore' ko use kar ke user ka data fetch karein
        DocumentSnapshot doc = await _authService.firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          _user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
          print("AuthProvider: User session found for: ${_user?.email}");
        } else {
          _user = null; // Firestore data missing hai, user session nahi mana jayega ya basic user
          print("AuthProvider: User session found, but Firestore data missing.");
        }
      } else {
        _user = null; // Koi user logged in nahi
        print("AuthProvider: No active user session.");
      }
    } catch (e) {
      _errorMessage = 'Error checking session: ${e.toString()}';
      _user = null;
      print("AuthProvider: Error checking session: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  // Naya method user profile ko update karne ke liye
  void updateUserProfile({String? fullName, String? email, String? profileImageUrl}) {
    if (_user != null) {
      _user = _user!.copyWith(
        fullName: fullName,
        email: email,
        profileImageUrl: profileImageUrl,
      );
      notifyListeners();
    }
  }

  // Naya method loading state ko manually set karne ke liye
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // Error message clear karne ka method
  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }
}