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
# 👋🏻 Hi, I'm Noor Mustafa

A passionate and results-driven *Flutter Developer* from *Bahawalpur, Pakistan, specializing in building elegant, scalable, and high-performance cross-platform mobile applications using **Flutter* and *Dart*.

With a strong understanding of *UI/UX principles, **state management, and **API integration*, I aim to deliver apps that are not only functional but also user-centric and visually compelling. My development approach emphasizes clean code, reusability, and performance.

---

## 🚀 What I Do

- 🧑🏻💻 *Flutter App Development* – I build cross-platform apps for Android, iOS, and the web using Flutter.
- 🔗 *API Integration* – I connect apps to powerful RESTful APIs and third-party services.
- 🎨 *UI/UX Design* – I craft responsive and animated interfaces that elevate the user experience.
- 🔐 *Authentication & Firebase* – I implement secure login systems and integrate Firebase services.
- ⚙ *State Management* – I use Provider, setState, and Riverpod (in-progress) for scalable app architecture.
- 🧠 *Clean Architecture* – I follow MVVM and MVC patterns for maintainable code.

---


## 🌟 Projects I'm Proud Of

- 🌤 **[Live Weather Check App](https://github.com/NoorMustafa4556/Live-Weather-Check-App)** – Real-time weather forecast using OpenWeatherMap API  
- 🤖 **[AI Chatbot (Gemini)](https://github.com/NoorMustafa4556/Ai-ChatBot)** – Conversational AI chatbot powered by Google’s Gemini  

- 🍔 **[Recipe App](https://github.com/NoorMustafa4556/Recipe-App)** – Discover recipes with images, categories, and step-by-step instructions  

- 📚 **[Palindrome Checker](https://github.com/NoorMustafa4556/Palindrome-Checker-App)** – A Theory of Automata-based project to identify palindromic strings  

> 🎯 Check out all my repositories on [github.com/NoorMustafa4556](https://github.com/NoorMustafa4556?tab=repositories)

---

## 🛠 Tech Stack & Tools

| Area                | Tools/Technologies |
|---------------------|--------------------|
| *Languages*       | Dart, JavaScript, Python (basic) |
| *Mobile Framework*| Flutter            |
| *Backend/Cloud*   | Firebase (Auth, Realtime DB, Storage), Django, Flask |
| *Frontend (Web)*  | React.js (basic), HTML, CSS, Bootstrap |
| *State Management*| Provider, setState, Riverpod (learning) |
| *API & Storage*   | REST APIs, HTTP, Shared Preferences, SQLite |
| *Design*          | Material, Cupertino, Lottie Animations, Gradient UI |
| *Version Control* | Git, GitHub        |
| *Tools*           | Android Studio, VS Code, Postman, Figma (basic) |

---

## 🧰 Tech Toolbox

<p align="left">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/>
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"/>
  <img src="https://img.shields.io/badge/Django-092E20?style=for-the-badge&logo=django&logoColor=white"/>
  <img src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB"/>
  <img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white"/>
  <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</p>

---

## 📈 Current Focus

- 💡 Enhancing Flutter animations and transitions
- 🤖 Implementing AI-based logic with Google Gemini API
- 📲 Building portfolio-level applications using full-stack Django & Flutter

---

## 📫 Let's Connect!

<p align="left">
  <a href="https://x.com/NoorMustafa4556" target="blank">
    <img src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="X / Twitter" height="30" width="40" />
  </a>
  <a href="https://www.linkedin.com/in/noormustafa4556/" target="blank">
    <img src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="LinkedIn" height="30" width="40" />
  </a>
  <a href="https://www.facebook.com/NoorMustafa4556" target="blank">
    <img src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/facebook.svg" alt="Facebook" height="30" width="40" />
  </a>
  <a href="https://instagram.com/noormustafa4556" target="blank">
    <img src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/instagram.svg" alt="Instagram" height="30" width="40" />
  </a>
  <a href="https://wa.me/923087655076" target="blank">
    <img src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/whatsapp.svg" alt="WhatsApp" height="30" width="40" />
  </a>
  <a href="https://www.tiktok.com/@noormustafa4556" target="blank">
    <img src="https://cdn-icons-png.flaticon.com/512/3046/3046122.png" alt="TikTok" height="30" width="30" />
  </a>
</p>

- 📍 *Location:* Bahawalpur, Punjab, Pakistan

---

> “Learning never stops. Every app I build makes me a better developer — one widget at a time.”

---
