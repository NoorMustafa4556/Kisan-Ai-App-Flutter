// lib/Providers/AuthProvider.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/UserModel.dart';
import '../Services/Auth/AuthService.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;


  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _authService.signInWithEmailAndPassword(email, password);
      print("AuthProvider: Login successful for: ${_user?.email}");
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      print("AuthProvider: Login failed: $e");
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup(String fullName, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _authService.signUpWithEmailAndPassword(fullName, email, password);
      print("AuthProvider: Signup successful for: ${_user?.email}");
    } catch (e) {
      _errorMessage = 'Signup failed: ${e.toString()}';
      print("AuthProvider: Signup failed: $e");
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout method
  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signOut();
      _user = null;
      print("AuthProvider: User logged out.");
    } catch (e) {
      _errorMessage = 'Logout failed: ${e.toString()}';
      print("AuthProvider: Logout failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // User session check method
  Future<void> checkUserSession() async {
    _isLoading = true;
    notifyListeners();

    try {

      if (_authService.firebaseAuth.currentUser != null) {
        String uid = _authService.firebaseAuth.currentUser!.uid;

        DocumentSnapshot doc = await _authService.firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          _user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
          print("AuthProvider: User session found for: ${_user?.email}");
        } else {
          _user = null;
          print("AuthProvider: User session found, but Firestore data missing.");
        }
      } else {
        _user = null;
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


  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }
}