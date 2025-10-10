// lib/Models/UserModel.dart

class UserModel {
  final String uid;
  final String email;
  final String? fullName; // Full name optional ho sakta hai
  final String? profileImageUrl; // Profile picture ka URL

  UserModel({
    required this.uid,
    required this.email,
    this.fullName,
    this.profileImageUrl,
  });

  // Factory constructor to create a UserModel from a JSON map (e.g., from Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  // Method to convert UserModel to a JSON map (e.g., for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'profileImageUrl': profileImageUrl,
    };
  }

  // CopyWith method for immutability
  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? profileImageUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}