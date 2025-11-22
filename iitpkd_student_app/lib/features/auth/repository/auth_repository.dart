import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import '../../../core/constants/app_constants.dart';
import '../../../core/models/user.dart';
import '../../../core/models/course.dart';
import '../../../core/error/failures.dart';

class AuthRepository {
  final http.Client client;
  String? _sessionCookie;

  AuthRepository(this.client);

  /// Login to IIT PKD records portal
  Future<Either<Failure, Map<String, dynamic>>> login(
    String username,
    String password,
  ) async {
    try {
      // Step 1: Get login page to extract CSRF token
      final loginPageResponse = await client.get(
        Uri.parse(AppConstants.loginUrl),
      );

      if (loginPageResponse.statusCode != 200) {
        return Left(ServerFailure('Failed to load login page'));
      }

      // Parse CSRF token from login page
      final document = html_parser.parse(loginPageResponse.body);
      final csrfToken = document
          .querySelector('input[name="authenticity_token"]')
          ?.attributes['value'];

      if (csrfToken == null) {
        return Left(ServerFailure('Failed to extract CSRF token'));
      }

      // Extract cookies from login page
      final cookies = loginPageResponse.headers['set-cookie'];

      // Step 2: Perform login
      final loginResponse = await client.post(
        Uri.parse(AppConstants.loginUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          if (cookies != null) 'Cookie': cookies,
        },
        body: {
          'authenticity_token': csrfToken,
          'user[email]': username,
          'user[password]': password,
          'commit': 'Sign in',
        },
      );

      // Check if login was successful
      if (loginResponse.statusCode == 200 &&
          !loginResponse.body.contains('Invalid Email or password')) {
        // Save session cookie
        _sessionCookie = loginResponse.headers['set-cookie'];

        // Extract user info from response
        final userDoc = html_parser.parse(loginResponse.body);
        final userName = userDoc.querySelector('.user-name')?.text.trim() ??
            username;

        final user = User(
          username: username,
          name: userName,
          rollNumber: username,
          email: '$username@iitpkd.ac.in',
        );

        return Right({
          'user': user,
          'session': _sessionCookie,
        });
      } else {
        return Left(AuthFailure('Invalid username or password'));
      }
    } catch (e) {
      return Left(NetworkFailure('Network error: ${e.toString()}'));
    }
  }

  /// Fetch available semesters
  Future<Either<Failure, List<String>>> fetchSemesters() async {
    try {
      if (_sessionCookie == null) {
        return Left(AuthFailure('Not logged in'));
      }

      final response = await client.get(
        Uri.parse(AppConstants.studentCoursesUrl),
        headers: {
          'Cookie': _sessionCookie!,
        },
      );

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final semesterOptions = document.querySelectorAll('select[name="semester"] option');

        final semesters = semesterOptions
            .map((option) => option.text.trim())
            .where((text) => text.isNotEmpty)
            .toList();

        return Right(semesters);
      } else {
        return Left(ServerFailure('Failed to fetch semesters'));
      }
    } catch (e) {
      return Left(NetworkFailure('Network error: ${e.toString()}'));
    }
  }

  /// Fetch courses for a semester
  Future<Either<Failure, List<Course>>> fetchCourses(String semester) async {
    try {
      if (_sessionCookie == null) {
        return Left(AuthFailure('Not logged in'));
      }

      final response = await client.post(
        Uri.parse(AppConstants.studentCoursesUrl),
        headers: {
          'Cookie': _sessionCookie!,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'semester': semester,
        },
      );

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final courseRows = document.querySelectorAll('table tbody tr');

        final courses = <Course>[];

        for (final row in courseRows) {
          final cells = row.querySelectorAll('td');
          if (cells.length >= 6) {
            courses.add(Course(
              courseCode: cells[0].text.trim(),
              courseName: cells[1].text.trim(),
              courseCategory: cells[2].text.trim(),
              ltpc: cells[3].text.trim(),
              slot: cells[4].text.trim(),
              instructor: cells[5].text.trim(),
            ));
          }
        }

        return Right(courses);
      } else {
        return Left(ServerFailure('Failed to fetch courses'));
      }
    } catch (e) {
      return Left(NetworkFailure('Network error: ${e.toString()}'));
    }
  }

  /// Logout
  Future<void> logout() async {
    _sessionCookie = null;
  }
}
