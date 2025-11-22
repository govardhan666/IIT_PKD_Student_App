import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';
import '../services/secure_storage_service.dart';

// Current user state provider
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>((ref) {
  return CurrentUserNotifier();
});

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier() : super(null) {
    _loadUser();
  }

  final SecureStorageService _storage = SecureStorageService();

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    if (userData != null) {
      state = User.fromJson(userData);
    }
  }

  Future<void> loginUser(User user, String username, String password) async {
    state = user;

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', user.toJson());
    await prefs.setBool('is_logged_in', true);

    // Save credentials to secure storage
    await _storage.saveCredentials(username, password);
  }

  Future<void> updateUser(User user) async {
    state = user;

    // Update in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', user.toJson());
  }

  Future<void> logout() async {
    state = null;

    // Clear from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    await prefs.setBool('is_logged_in', false);
    await prefs.remove('selected_semester');
    await prefs.remove('courses');
    await prefs.remove('timetable');

    // Clear from secure storage
    await _storage.clearAll();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  Future<Map<String, String?>> getCredentials() async {
    return await _storage.getCredentials();
  }
}
