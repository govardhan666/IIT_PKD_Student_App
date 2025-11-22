class AppConstants {
  // API URLs
  static const String baseUrl = 'https://records.iitpkd.ac.in';
  static const String loginUrl = '$baseUrl/';
  static const String studentCoursesUrl = '$baseUrl/course_registration_reports/student_courses';
  static const String resultsUrl = '$baseUrl/grades/view_results';
  static const String facultyUrl = 'https://iitpkd.ac.in/faculty-list';
  static const String wifiLoginUrl = 'https://netaccess.iitpkd.ac.in:1442/';

  // Weather API (OpenMeteo - free, no API key required)
  static const String weatherApiUrl = 'https://api.open-meteo.com/v1/forecast';
  static const double iitPalakkadLat = 10.7756;
  static const double iitPalakkadLon = 76.6534;

  // App Info
  static const String appName = 'IIT Palakkad Student';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUsername = 'username';
  static const String keyPassword = 'password';
  static const String keyUserData = 'user_data';
  static const String keySelectedSemester = 'selected_semester';
  static const String keyThemeMode = 'theme_mode';

  // Session
  static const Duration sessionTimeout = Duration(minutes: 15);
  static const Duration sessionRefreshThreshold = Duration(minutes: 14);

  // Time Slots
  static const Map<String, List<TimeSlot>> weeklySlots = {
    'Monday': [
      TimeSlot(name: 'A', start: '08:00', end: '08:50'),
      TimeSlot(name: 'B', start: '09:00', end: '09:50'),
      TimeSlot(name: 'C', start: '10:00', end: '10:50'),
      TimeSlot(name: 'D', start: '11:00', end: '11:50'),
      TimeSlot(name: 'H', start: '12:05', end: '12:55'),
      TimeSlot(name: 'I', start: '14:00', end: '15:15'),
      TimeSlot(name: 'J', start: '15:30', end: '16:45'),
      TimeSlot(name: 'R1', start: '17:10', end: '18:00'),
      TimeSlot(name: 'PM1', start: '09:00', end: '11:45'),
      TimeSlot(name: 'PA1', start: '14:00', end: '16:45'),
    ],
    'Tuesday': [
      TimeSlot(name: 'B', start: '08:00', end: '08:50'),
      TimeSlot(name: 'F', start: '09:00', end: '10:15'),
      TimeSlot(name: 'G', start: '10:30', end: '11:45'),
      TimeSlot(name: 'M', start: '12:00', end: '12:50'),
      TimeSlot(name: 'K', start: '14:00', end: '15:15'),
      TimeSlot(name: 'L', start: '15:30', end: '16:45'),
      TimeSlot(name: 'R2', start: '17:10', end: '18:00'),
      TimeSlot(name: 'PM2', start: '09:00', end: '11:45'),
      TimeSlot(name: 'PA2', start: '14:00', end: '16:45'),
    ],
    'Wednesday': [
      TimeSlot(name: 'C', start: '08:00', end: '08:50'),
      TimeSlot(name: 'D', start: '09:00', end: '09:50'),
      TimeSlot(name: 'E', start: '10:00', end: '10:50'),
      TimeSlot(name: 'A', start: '11:00', end: '11:50'),
      TimeSlot(name: 'H', start: '12:05', end: '12:55'),
      TimeSlot(name: 'Q', start: '14:00', end: '14:50'),
      TimeSlot(name: 'R3', start: '15:00', end: '15:50'),
      TimeSlot(name: 'CMN-A', start: '16:00', end: '16:50'),
      TimeSlot(name: 'CMN-B', start: '17:00', end: '17:50'),
      TimeSlot(name: 'PM3', start: '09:00', end: '11:45'),
      TimeSlot(name: 'PA3', start: '14:00', end: '15:50'),
      TimeSlot(name: 'EML', start: '17:10', end: '18:00'),
    ],
    'Thursday': [
      TimeSlot(name: 'D', start: '08:00', end: '08:50'),
      TimeSlot(name: 'G', start: '09:00', end: '10:15'),
      TimeSlot(name: 'F', start: '10:30', end: '11:45'),
      TimeSlot(name: 'M', start: '12:00', end: '12:50'),
      TimeSlot(name: 'L', start: '14:00', end: '15:15'),
      TimeSlot(name: 'K', start: '15:30', end: '16:45'),
      TimeSlot(name: 'R4', start: '17:10', end: '18:00'),
      TimeSlot(name: 'PM4', start: '09:00', end: '11:45'),
      TimeSlot(name: 'PA4', start: '14:00', end: '16:45'),
    ],
    'Friday': [
      TimeSlot(name: 'E', start: '08:00', end: '08:50'),
      TimeSlot(name: 'A', start: '09:00', end: '09:50'),
      TimeSlot(name: 'B', start: '10:00', end: '10:50'),
      TimeSlot(name: 'C', start: '11:00', end: '11:50'),
      TimeSlot(name: 'H', start: '12:05', end: '12:55'),
      TimeSlot(name: 'J', start: '14:00', end: '15:15'),
      TimeSlot(name: 'I', start: '15:30', end: '16:45'),
      TimeSlot(name: 'R5', start: '17:10', end: '18:00'),
      TimeSlot(name: 'PM5', start: '09:00', end: '11:45'),
      TimeSlot(name: 'PA5', start: '14:00', end: '16:45'),
    ],
  };
}

class TimeSlot {
  final String name;
  final String start;
  final String end;

  const TimeSlot({
    required this.name,
    required this.start,
    required this.end,
  });
}
