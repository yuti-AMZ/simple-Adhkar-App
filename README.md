# 📘 Daily Adhkar Tracker

**Daily Adhkar Tracker** is a Flutter mobile app designed to help users track their daily Hadith recitation and adhkar. This app focuses on simplicity, beautiful UI, offline support, and Islamic lifestyle habit tracking.  

It’s built to satisfy real-world Flutter development skills: API integration, state management, animations, navigation, and local storage.

---

## 🌟 Features

### Core Features (Task Instructions)
- **Fetch and display Hadith / Adhkar**
  - Arabic + English translation
  - Online via HadithHub API
  - Offline fallback using local JSON
- **Daily Counter**
  - Increment your adhkar count
  - Animated button with tactile feedback
  - Auto-reset every day
- **History Tracking**
  - Save and display all previous days
  - ListView with dates and counts
  - Dark/Light mode compatible

### Additional Enhancements
- **Splash Screen** with fade-in animation
- **Dark/Light Theme Toggle**
- **Google Fonts & Modern UI**
- **Animated Adhkar Card & Slide Navigation**
- **Tasbih Mode**
  - Large counter with vibration feedback
  - Reset functionality
- **Daily Reminder Notifications**
  - Push notification at a configurable time
- **Offline Support**
  - Local JSON fallback if API fails

---

## 📂 Project Structure

lib/
main.dart
theme/
theme_manager.dart
app_themes.dart
models/
hadith_model.dart
services/
hadith_service.dart
local_storage.dart
notification_service.dart
widgets/
adhkar_card.dart
screens/
splash_screen.dart
today_screen.dart
history_screen.dart
tasbih_screen.dart
utils/
slide_transition.dart
assets/
hadith.json

yaml
Copy code

---

## ⚙️ Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/daily_adhkar_tracker.git
cd daily_adhkar_tracker
Install dependencies

bash
Copy code
flutter pub get
Run the app

bash
Copy code
flutter run
Build APK (Release)

bash
Copy code
flutter build apk --release
Optional

Modify daily notification time in main.dart

Add more Hadith entries in assets/hadith.json

🌐 API Used
HadithHub API

Arabic + English text

Public, structured JSON

Fallback: assets/hadith.json if offline

📸 Screenshots
Splash Screen	Today Screen	History Screen	Tasbih Mode

Replace above with your own screenshots for professional presentation.

🎯 Notes
Dark and light themes are fully supported.

History stores all previous days.

App is ready for GitHub submission and APK release.

Perfect for daily Islamic habit tracking.

🛠 Built With
Flutter – Front-end framework

Dart – Programming language

SharedPreferences – Local storage

Flutter Local Notifications – Daily reminders

Google Fonts – Typography

http – API requests

✅ Author
Hayat Zeynu
Muslim Software Engineer | Flutter Developer | Lifelong learner