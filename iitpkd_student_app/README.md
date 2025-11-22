# IIT Palakkad Student App

A comprehensive mobile application for IIT Palakkad students, providing easy access to academic resources, timetables, bus schedules, mess menus, and more.

## 📱 Features

### 🏠 Home Page
- **Weather Widget**: Real-time weather information for Palakkad
- **Upcoming Classes**: See your next classes at a glance
- **Quick Access**: Fast navigation to frequently used features
  - Results
  - Exams
  - Faculty Directory
  - WiFi Auto-Login
- **For You Section**: Curated resources and links for students

### 📅 Timetable
- Automatically generated from your registered courses
- Based on IIT Palakkad's slot system (Aug-Dec 2025)
- Color-coded classes for easy identification
- Supports lab sessions (PM/PA slots)
- View by day with tabbed interface

### 🚌 Bus Schedule
- Real-time bus schedules between Nila and Sahyadri campuses
- Special routes to Palakkad town
- Wise Park Junction routes
- Separate schedules for:
  - Working Days
  - Saturdays/Holidays
  - Sundays

### 🍽️ Mess Menu
- Complete mess menu for all meals
- Breakfast, Lunch, Snacks, and Dinner
- Vegetarian and Non-Vegetarian options clearly marked
- Week 1 & 3 and Week 2 & 4 menus
- View by day with current week indicator

### 👤 Account
- User profile information
- Dark mode toggle
- App settings
- Logout functionality

### 📊 Additional Features
- **Results**: View semester grades (Coming soon)
- **Faculty Directory**: Browse faculty list with search
- **WiFi Auto-Login**: Automatic authentication to campus WiFi
- **Exams**: View exam schedules (Coming soon)

## 🎨 Design

- Material Design 3 (Material You)
- IIT Palakkad brand colors (Blue & Orange)
- Dark mode support
- Smooth animations and transitions
- Responsive layout

## 🛠️ Technology Stack

### Frontend
- **Framework**: Flutter 3.24.2+
- **Language**: Dart
- **State Management**: Riverpod
- **UI Components**: Material 3

### Core Dependencies
- `flutter_riverpod`: State management
- `http` & `dio`: API calls
- `html`: Web scraping for portal data
- `flutter_secure_storage`: Secure credential storage
- `shared_preferences`: Local data persistence
- `iconsax_flutter`: Icon library
- `carousel_slider`: Carousel components
- `url_launcher`: External link handling

### Services
- Weather API: OpenMeteo (free, no API key required)
- Authentication: IIT Palakkad Records Portal
- Faculty Data: IIT Palakkad website

## 📦 Installation

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions
- Android device/emulator or iOS device/simulator

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/IIT_PKD_Student.git
   cd IIT_PKD_Student/iitpkd_student_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

4. **Build for release**
   ```bash
   # Android
   flutter build apk --release

   # iOS
   flutter build ios --release
   ```

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/                              # Core functionality
│   ├── common/
│   │   └── widget/
│   │       └── bottom_navigation_bar.dart
│   ├── constants/
│   │   └── app_constants.dart        # App-wide constants
│   ├── error/
│   │   └── failures.dart             # Error handling
│   ├── models/                        # Data models
│   │   ├── user.dart
│   │   ├── course.dart
│   │   ├── timetable_entry.dart
│   │   ├── weather.dart
│   │   └── faculty.dart
│   ├── network/
│   │   └── connection_checker.dart
│   ├── providers/                     # Riverpod providers
│   │   ├── current_user_provider.dart
│   │   └── theme_provider.dart
│   ├── services/
│   │   └── secure_storage_service.dart
│   ├── theme/
│   │   └── app_theme.dart            # Theme configuration
│   └── utils/
│       └── timetable_generator.dart  # Timetable logic
│
└── features/                          # Feature modules
    ├── auth/                          # Authentication
    │   ├── repository/
    │   │   └── auth_repository.dart
    │   └── view/
    │       └── pages/
    │           ├── login_page.dart
    │           └── semester_selection_page.dart
    │
    ├── home/                          # Home page
    │   ├── view/
    │   │   ├── pages/
    │   │   │   ├── home_page.dart
    │   │   │   ├── results_page.dart
    │   │   │   ├── exams_page.dart
    │   │   │   ├── faculty_page.dart
    │   │   │   └── wifi_page.dart
    │   │   └── widgets/
    │   │       ├── weather_container.dart
    │   │       ├── quick_access_grid.dart
    │   │       ├── for_you_carousel.dart
    │   │       └── upcoming_classes_widget.dart
    │
    ├── timetable/                     # Timetable feature
    │   └── view/
    │       └── pages/
    │           └── timetable_page.dart
    │
    ├── bus_schedule/                  # Bus schedule
    │   └── view/
    │       └── pages/
    │           └── bus_schedule_page.dart
    │
    ├── mess_menu/                     # Mess menu
    │   └── view/
    │       └── pages/
    │           └── mess_menu_page.dart
    │
    └── account/                       # Account/Profile
        └── view/
            └── pages/
                └── account_page.dart
```

## 🔐 Authentication

The app authenticates with the IIT Palakkad Records Portal:

1. **Login**: Enter your portal credentials
2. **Semester Selection**: Choose your current semester
3. **Data Fetching**: Courses are automatically fetched
4. **Timetable Generation**: Timetable is auto-generated based on slot system

### Security
- Credentials are stored using `flutter_secure_storage`
- Platform-specific encryption (Keychain on iOS, AES on Android)
- Session management with automatic logout

## 📊 Timetable System

The app uses IIT Palakkad's slot system (Aug-Dec 2025):

### Slot Types
- **Theory Slots**: A, B, C, D, H (3 credits, 50 mins each)
- **Extended Slots**: F, G, I, J, K, L (3 credits, 75 mins each)
- **Short Slots**: E, M (2 credits, 50 mins each)
- **Single Credit**: Q, R1-R5 (1 credit, 50 mins)
- **Lab Slots**: PM1-PM5 (morning), PA1-PA5 (afternoon)

### Features
- Automatic parsing of course slots (e.g., "C + PA3")
- Support for combined slots
- Lab session identification
- Color-coded display

## 🚀 Usage Guide

### First Time Setup
1. Launch the app
2. Login with your IIT Palakkad credentials
3. Select your current semester
4. Your timetable will be automatically generated

### Daily Use
- **View Today's Classes**: Open the app to see upcoming classes
- **Check Weather**: View Palakkad weather on home page
- **Check Bus Times**: Navigate to Bus Schedule tab
- **View Mess Menu**: Navigate to Mess Menu tab
- **Connect to WiFi**: Use WiFi Auto-Login feature

### Managing Account
- Toggle dark mode from Account page
- Logout to switch accounts
- Update semester from settings (coming soon)

## 🔄 Data Sources

### IIT Palakkad Records Portal
- Student authentication
- Course registration data
- Semester information
- Results (coming soon)

### IIT Palakkad Website
- Faculty directory
- Department information

### Static Data
- Slot system (from PDF)
- Bus schedules (from PDF)
- Mess menu (from PDF)

### External APIs
- OpenMeteo Weather API (free, no key required)

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style
- Follow Dart/Flutter best practices
- Use meaningful variable names
- Comment complex logic
- Write widget tests for critical features

## 🐛 Known Issues

- Results fetching not yet implemented
- Exam schedule not yet implemented
- Faculty scraping may need adjustments based on website structure
- WiFi auto-login requires testing with actual network

## 🔮 Future Enhancements

- [ ] Push notifications for class reminders
- [ ] Attendance tracking
- [ ] Academic calendar integration
- [ ] Club and event listings
- [ ] Offline mode for timetable
- [ ] Share timetable as image
- [ ] Grade calculator
- [ ] PDF viewer for course materials
- [ ] Semester GPA calculator

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

- **Your Name** - Initial work

## 🙏 Acknowledgments

- IIT Palakkad for providing the educational environment
- VITAP Student App for architectural inspiration
- Flutter and Dart communities for excellent documentation
- OpenMeteo for free weather API

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Contact: your.email@example.com

## 📱 Screenshots

(Add screenshots here once the app is running)

---

**Note**: This app is an independent student project and is not officially affiliated with IIT Palakkad. Use at your own discretion.
