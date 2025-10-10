// lib/Utils/AppConstants.dart - COMPLETE UPDATED CODE

class AppConstants {
  static const String appName = "Kisan AI Advisor";
  static const String loginTitle = "Welcome Back!";
  static const String signupTitle = "Create Your Account";

  // Hints
  static const String emailHint = "Email";
  static const String passwordHint = "Password";
  static const String fullNameHint = "Full Name";
  static const String confirmPasswordHint = "Confirm Password";
  static const String searchHint = "Search services...";
  static const String currentPasswordHint = "Current Password";
  static const String newPasswordHint = "New Password";
  static const String confirmNewPasswordHint = "Confirm New Password";

  // Buttons
  static const String loginButtonText = "Login";
  static const String signupButtonText = "Sign Up";
  static const String updateProfileButtonText = "Update Profile";
  static const String updatePasswordButtonText = "Update Password";
  static const String logoutButtonText = "Logout";


  // Link/Navigation texts
  static const String forgotPassword = "Forgot Password?";
  static const String noAccountText = "Don't have an account?";
  static const String alreadyAccountText = "Already have an account?";

  // Drawer Menu Items
  static const String homeDrawer = "Home";
  static const String settingsDrawer = "Settings";
  static const String logoutDrawer = "Logout";

  // Home Screen
  static const String ourServices = "Our Services";
  static const String cropDiseaseDetection = "Crop Disease Detection";
  static const String CropYieldForcaster = "Crop Yield Forecaster";
  static const String fertilizerRecommendation = "Fertilizer Recommendation"; // Yeh ab use nahi hoga agar card remove kar diye
  static const String weatherForecasting = "Weather Forecasting";
  static const String marketPricePrediction = "Market Price Prediction"; // Yeh ab use nahi hoga agar card remove kar diye
  static const String kisanAIChat = "Kisan AI Chat"; // Chat screen ka title

  // NEW: Constants for the new cards
  static const String chatWithKisanAI = "Chat With Kisan AI"; // For the new Chat card title
  static const String contactUs = "Contact Us"; // For the new Contact Us card title


  // Settings Screen
  static const String profileDetailsTitle = "Profile Details";
  static const String changePasswordTitle = "Change Password";


  // Default User Info (for Drawer if user is null)
  static const String farmerUserName = "Guest User";
  static const String farmerUserEmail = "guest@example.com";

  // ------------------------- THEME CONSTANTS (NEW) -------------------------
  static const String themeSettingsTitle = "Theme Settings";
  static const String systemDefaultTheme = "System Default";
  static const String lightTheme = "Light Theme";
  static const String darkTheme = "Dark Theme";
}