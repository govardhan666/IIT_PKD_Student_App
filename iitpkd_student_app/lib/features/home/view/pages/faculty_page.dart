import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/models/faculty.dart';
import '../../../../core/constants/app_constants.dart';

// Faculty provider
final facultyProvider = FutureProvider<List<Faculty>>((ref) async {
  try {
    final response = await http.get(Uri.parse(AppConstants.facultyUrl));

    if (response.statusCode == 200) {
      final document = html_parser.parse(response.body);
      final facultyElements = document.querySelectorAll('.faculty-card');

      final faculties = <Faculty>[];

      for (final element in facultyElements) {
        final name = element.querySelector('.faculty-name')?.text.trim() ?? '';
        final designation =
            element.querySelector('.faculty-designation')?.text.trim() ?? '';
        final department =
            element.querySelector('.faculty-department')?.text.trim() ?? '';
        final email = element.querySelector('.faculty-email')?.text.trim();

        if (name.isNotEmpty) {
          faculties.add(Faculty(
            name: name,
            designation: designation,
            department: department,
            email: email,
          ));
        }
      }

      // If scraping fails, return sample data
      if (faculties.isEmpty) {
        return [
          Faculty(
            name: 'Dr. Sample Faculty',
            designation: 'Professor',
            department: 'Computer Science',
            email: 'sample@iitpkd.ac.in',
          ),
        ];
      }

      return faculties;
    } else {
      throw Exception('Failed to load faculty');
    }
  } catch (e) {
    // Return sample data on error
    return [
      Faculty(
        name: 'Faculty information will be loaded from IIT Palakkad website',
        designation: '',
        department: '',
      ),
    ];
  }
});

class FacultyPage extends ConsumerStatefulWidget {
  const FacultyPage({super.key});

  @override
  ConsumerState<FacultyPage> createState() => _FacultyPageState();
}

class _FacultyPageState extends ConsumerState<FacultyPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final facultyAsync = ref.watch(facultyProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search faculty...',
                prefixIcon: const Icon(Iconsax.search_normal_copy),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // Faculty list
          Expanded(
            child: facultyAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load faculty',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.refresh(facultyProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (faculties) {
                final filteredFaculties = faculties.where((faculty) {
                  return faculty.name.toLowerCase().contains(_searchQuery) ||
                      faculty.department.toLowerCase().contains(_searchQuery) ||
                      faculty.designation.toLowerCase().contains(_searchQuery);
                }).toList();

                if (filteredFaculties.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.teacher_copy,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No faculty found',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredFaculties.length,
                  itemBuilder: (context, index) {
                    final faculty = filteredFaculties[index];
                    return _FacultyCard(faculty: faculty);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FacultyCard extends StatelessWidget {
  final Faculty faculty;

  const _FacultyCard({required this.faculty});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            faculty.name.isNotEmpty ? faculty.name[0].toUpperCase() : 'F',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          faculty.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (faculty.designation.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(faculty.designation),
            ],
            if (faculty.department.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                faculty.department,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (faculty.email != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    faculty.email!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Show faculty details
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(faculty.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (faculty.designation.isNotEmpty)
                    Text('Designation: ${faculty.designation}'),
                  if (faculty.department.isNotEmpty)
                    Text('Department: ${faculty.department}'),
                  if (faculty.email != null) Text('Email: ${faculty.email}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
