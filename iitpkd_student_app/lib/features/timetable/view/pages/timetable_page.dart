import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/timetable_entry.dart';

// Timetable provider
final timetableProvider = FutureProvider<Timetable?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final timetableJson = prefs.getString('timetable');

  if (timetableJson != null) {
    return Timetable.fromJson(timetableJson);
  }
  return null;
});

class TimetablePage extends ConsumerStatefulWidget {
  const TimetablePage({super.key});

  @override
  ConsumerState<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends ConsumerState<TimetablePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  @override
  void initState() {
    super.initState();
    final today = DateTime.now().weekday - 1; // Monday = 0
    final initialIndex = today < 5 ? today : 0;
    _tabController = TabController(
      length: _days.length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timetableAsync = ref.watch(timetableProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _days.map((day) => Tab(text: day)).toList(),
        ),
      ),
      body: timetableAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text(
                'Failed to load timetable',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.refresh(timetableProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (timetable) {
          if (timetable == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No timetable available',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please select a semester from settings',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: _days.map((day) {
              final dayEntries = timetable.getEntriesForDay(day);

              if (dayEntries.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.celebration,
                        size: 48,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No classes on $day',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: dayEntries.length,
                itemBuilder: (context, index) {
                  final entry = dayEntries[index];
                  return _TimetableCard(entry: entry);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _TimetableCard extends StatelessWidget {
  final TimetableEntry entry;

  const _TimetableCard({required this.entry});

  Color _getSlotColor(String slotName) {
    if (slotName.startsWith('PM') || slotName.startsWith('PA')) {
      return Colors.purple;
    }
    if (slotName.length == 1) {
      // Single letter slots (A, B, C, etc.)
      final colors = [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.red,
        Colors.teal,
        Colors.pink,
        Colors.indigo,
      ];
      return colors[slotName.codeUnitAt(0) % colors.length];
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final course = entry.course;

    if (course == null) return const SizedBox.shrink();

    final slotColor = _getSlotColor(entry.slotName);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Show course details
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(course.courseName),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(
                    icon: Icons.code,
                    label: 'Course Code',
                    value: course.courseCode,
                  ),
                  const SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.category,
                    label: 'Category',
                    value: course.courseCategory,
                  ),
                  const SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.access_time,
                    label: 'Time',
                    value: '${entry.startTime} - ${entry.endTime}',
                  ),
                  const SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.person,
                    label: 'Instructor',
                    value: course.instructor,
                  ),
                  const SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.schedule,
                    label: 'Slot',
                    value: course.slot,
                  ),
                  const SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.star,
                    label: 'Credits',
                    value: '${course.totalCredits}',
                  ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Time and slot indicator
              Container(
                width: 4,
                height: 80,
                decoration: BoxDecoration(
                  color: slotColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),

              // Course details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: slotColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            entry.slotName,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: slotColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          entry.isLab ? Icons.science : Icons.book,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.courseName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.courseCode,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${entry.startTime} - ${entry.endTime}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
