import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repository/auth_repository.dart';
import '../../../../core/models/course.dart';
import '../../../../core/models/timetable_entry.dart';
import '../../../../core/utils/timetable_generator.dart';
import '../../../../core/common/widget/bottom_navigation_bar.dart';

class SemesterSelectionPage extends ConsumerStatefulWidget {
  final AuthRepository repository;

  const SemesterSelectionPage({
    super.key,
    required this.repository,
  });

  @override
  ConsumerState<SemesterSelectionPage> createState() =>
      _SemesterSelectionPageState();
}

class _SemesterSelectionPageState
    extends ConsumerState<SemesterSelectionPage> {
  List<String> _semesters = [];
  String? _selectedSemester;
  bool _isLoadingSemesters = true;
  bool _isLoadingCourses = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSemesters();
  }

  Future<void> _fetchSemesters() async {
    setState(() {
      _isLoadingSemesters = true;
      _errorMessage = null;
    });

    final result = await widget.repository.fetchSemesters();

    if (mounted) {
      result.fold(
        (failure) {
          setState(() {
            _isLoadingSemesters = false;
            _errorMessage = failure.message;
          });
        },
        (semesters) {
          setState(() {
            _semesters = semesters;
            _isLoadingSemesters = false;
            if (semesters.isNotEmpty) {
              _selectedSemester = semesters.first;
            }
          });
        },
      );
    }
  }

  Future<void> _proceed() async {
    if (_selectedSemester == null) {
      return;
    }

    setState(() {
      _isLoadingCourses = true;
      _errorMessage = null;
    });

    final result = await widget.repository.fetchCourses(_selectedSemester!);

    if (mounted) {
      result.fold(
        (failure) {
          setState(() {
            _isLoadingCourses = false;
            _errorMessage = failure.message;
          });
        },
        (courses) async {
          // Generate timetable
          final timetable =
              TimetableGenerator.generateTimetable(courses, _selectedSemester!);

          // Save to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('selected_semester', _selectedSemester!);
          await prefs.setString(
            'courses',
            courses.map((c) => c.toJson()).toList().toString(),
          );
          await prefs.setString('timetable', timetable.toJson());

          setState(() {
            _isLoadingCourses = false;
          });

          // Navigate to home
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const AppBottomNavigationBar(),
              ),
              (route) => false,
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Semester'),
      ),
      body: _isLoadingSemesters
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Select your current semester',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This will be used to fetch your courses and generate your timetable',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Semester dropdown
                  if (_semesters.isEmpty)
                    const Text('No semesters available')
                  else
                    DropdownButtonFormField<String>(
                      value: _selectedSemester,
                      decoration: const InputDecoration(
                        labelText: 'Semester',
                        border: OutlineInputBorder(),
                      ),
                      items: _semesters.map((semester) {
                        return DropdownMenuItem(
                          value: semester,
                          child: Text(semester),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSemester = value;
                        });
                      },
                    ),
                  const SizedBox(height: 24),

                  // Error message
                  if (_errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  if (_errorMessage != null) const SizedBox(height: 16),

                  // Proceed button
                  FilledButton(
                    onPressed: (_isLoadingCourses || _selectedSemester == null)
                        ? null
                        : _proceed,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoadingCourses
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),

                  const Spacer(),

                  // Info card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Note',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your timetable will be automatically generated based on the slot system. '
                            'You can change the semester later from the settings.',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
