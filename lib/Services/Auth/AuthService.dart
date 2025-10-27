
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/UserModel.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // FirebaseAuth instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // FirebaseFirestore instance

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseFirestore get firestore => _firestore;

  // User sign in With email & password
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Fetch Details After User Login
        DocumentSnapshot doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
        if (doc.exists) {
          return UserModel.fromJson(doc.data() as Map<String, dynamic>);
        } else {

          return UserModel(uid: firebaseUser.uid, email: firebaseUser.email ?? 'No Email');
        }
      } else {
        throw Exception('User is null after sign in.');
      }
    } on FirebaseAuthException catch (e) {
      // Firebase specific errors  handle
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    } catch (e) {
      // General errors ko handle karein
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Naye user ko email, password aur fullName se sign up karwana
  Future<UserModel> signUpWithEmailAndPassword(String fullName, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Naya user create hone ke baad, uski details Firestore mein save karein
        UserModel newUser = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? email, // Firebase se email lein ya provide kiya hua email
          fullName: fullName,
          profileImageUrl: null, // Initially null
        );


        await _firestore.collection('users').doc(firebaseUser.uid).set(newUser.toJson());

        return newUser;
      } else {
        throw Exception('User is null after sign up.');
      }
    } on FirebaseAuthException catch (e) {
      // Firebase specific errors  handle
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception('Signup failed: ${e.message}');
      }
    } catch (e) {
      // General errors  handle
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  // User sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      print("AuthService: User signed out from Firebase.");
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}