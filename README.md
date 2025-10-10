# 🌾 Kisan AI App (Flutter)

A **smart AI-powered agricultural assistant** built using **Flutter**, designed to help farmers make informed decisions through real-time insights. The app integrates **AI/ML**, **weather APIs**, and **data analytics** to provide features like **crop recommendations**, **disease detection**, **weather forecasts**, and **market trends** — all in one user-friendly mobile platform.

This project aims to **bridge technology and agriculture**, empowering farmers with intelligent tools for **sustainable farming**, **resource management**, and **yield improvement**.

---
## 🌟 Description

Kisan AI App is an innovative, AI-powered agricultural companion designed to empower farmers with intelligent insights and real-time decision support. Built using Flutter, this app harnesses the power of Artificial Intelligence (AI), Machine Learning (ML), and Data Analytics to simplify farming operations and improve crop productivity.

Through a unified and user-friendly interface, farmers can access personalized crop recommendations, AI-based disease detection, fertilizer guidance, and real-time weather forecasts — all tailored to their local environment. The app also integrates market rate tracking to help farmers make informed financial decisions, ensuring that technology directly supports their daily livelihood.

Designed with a strong emphasis on clean architecture and scalable development, the Kisan AI App follows the principle of Separation of Concerns, making the codebase modular, maintainable, and ready for future enhancements. Its offline-first architecture ensures uninterrupted usability in rural or low-connectivity regions, while Firebase integration provides secure authentication and real-time cloud synchronization.

By combining AI-driven insights with modern mobile technology, this app serves as a bridge between traditional farming practices and the digital future — empowering farmers to make smarter, data-backed decisions and achieve higher yields with fewer resources. 🌾📱

---

## ✨ Key Features

- 🌾 **AI Crop Recommendations:** Get smart suggestions based on soil, weather, and location.
- 🌤️ **Weather Forecasting:** View real-time and weekly forecasts for planning farm activities.
- 🦠 **Disease Detection:** Identify crop diseases via image-based AI prediction.
- 💹 **Market Price Insights:** Stay updated on crop market rates to make profitable decisions.
- 🛰️ **Offline Support:** Works seamlessly in low-connectivity regions.
- 💬 **Multilingual Support:** Available in multiple languages for accessibility.
- 🧠 **Data-Driven Insights:** Utilizes AI/ML models for personalized advice.
- 🔒 **Secure & Private:** Data is securely handled with Firebase integration.

---

## 📱 App Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/1.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/2.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/3.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/4.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/5.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/6.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/7.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/8.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/9.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/10.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/11.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/12.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/13.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/14.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/15.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/16.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/17.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/18.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/19.png" width="30%"/>
  <img src="https://raw.githubusercontent.com/NoorMustafa4556/Kisan-Ai-App-Flutter/main/assets/images/20.png" width="30%"/>
</p>

---



## 🛠️ Tech Stack

| Area | Technology |
|------|-------------|
| **Framework** | Flutter |
| **Language** | Dart |
| **Backend** | Firebase / Node.js (if applicable) |
| **AI/ML** | TensorFlow Lite / Python-trained Models |
| **APIs** | OpenWeatherMap, Agri APIs, Google ML Kit |
| **Database** | Firestore / SQLite |
| **State Management** | Provider |
| **Design** | Material Design 3, Responsive UI |

---

## 🚀 Getting Started

Follow these steps to run the project locally.

### Prerequisites
- Flutter SDK installed → [Install Flutter](https://docs.flutter.dev/get-started/install)
- VS Code / Android Studio
- Emulator or physical Android device

### Setup Steps


## Clone this repository
```bash
git clone https://github.com/NoorMustafa4556/Kisan-Ai-App-Flutter.git
```
## Navigate into project folder
```bash
cd Kisan-Ai-App-Flutter
```

## Get dependencies
```bash
flutter pub get
```
## Run the app
```bash
flutter run
```
##  📁 Folder Structure
```bash
lib/
├── Models/
│ └── UserModel.dart
│
├── Providers/
│ ├── AuthProvider.dart
│ └── ThemeProvider.dart
│
├── Screens/
│ ├── Auth/
│ │ ├── LoginScreen.dart
│ │ └── SignUpScreen.dart
│ ├── Chat/
│ ├── ContactUsScreen.dart
│ ├── CropDiseaseDetectionScreen.dart
│ ├── CropYieldPredictor.dart
│ ├── FertilizerRecommendationScreen.dart
│ ├── HomeScreen.dart
│ ├── MarketPriceScreen.dart
│ ├── SettingsScreen.dart
│ ├── SplashScreen.dart
│ ├── ThemeSelectionScreen.dart
│ └── WeatherScreen.dart
│
├── Services/
│ ├── Auth/
│ │ └── AuthService.dart
│
├── Utils/
│ ├── AppConstants.dart
│ ├── AppStyles.dart
│ └── ChatLanguages.dart
│
├── firebase_options.dart
└── main.dart
```
