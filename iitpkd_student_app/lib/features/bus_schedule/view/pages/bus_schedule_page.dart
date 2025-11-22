import 'package:flutter/material.dart';

class BusSchedulePage extends StatefulWidget {
  const BusSchedulePage({super.key});

  @override
  State<BusSchedulePage> createState() => _BusSchedulePageState();
}

class _BusSchedulePageState extends State<BusSchedulePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Schedule'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Working Days'),
            Tab(text: 'Saturday/Holidays'),
            Tab(text: 'Sunday'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _WorkingDaysSchedule(),
          _SaturdaySchedule(),
          _SundaySchedule(),
        ],
      ),
    );
  }
}

class _WorkingDaysSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _RouteCard(
          title: 'Nila to Sahyadri',
          icon: Icons.arrow_forward,
          times: const [
            '8:30', '9:25', '9:45', '10:20', '10:45', '11:15', '11:50',
            '12:15', '12:30', '1:00', '1:30', '1:45', '2:15', '2:45',
            '3:20', '3:45', '4:30', '5:00', '5:15', '5:45', '6:00',
            '6:30', '7:00', '7:30', '8:00', '8:30', '9:00', '10:00',
            '11:00', '12:00',
          ],
          note: 'Multiple buses at bold timings: 11:50, 12:30, 5:15, 8:00',
        ),
        const SizedBox(height: 16),
        _RouteCard(
          title: 'Sahyadri to Nila',
          icon: Icons.arrow_back,
          times: const [
            '7:45', '8:15', '8:30', '8:45', '9:00', '9:25', '9:45',
            '10:20', '10:45', '11:15', '11:50', '12:15', '12:30',
            '1:00', '1:30', '1:45', '2:15', '2:45', '3:20', '3:45',
            '4:30', '5:00', '5:15', '5:45', '6:00', '6:30', '7:00',
            '7:30', '8:00', '9:15', '10:15', '11:15',
          ],
          note: 'Multiple buses at bold timings: 8:30, 9:00, 10:20, 11:50, 12:30, 5:15',
        ),
        const SizedBox(height: 16),
        _SpecialRoutesCard(
          routes: [
            {
              'title': 'Palakkad Town Route 1',
              'schedule':
                  'Nila Gate: 7:40 AM → Palakkad 8:25 AM → Sahyadri 8:55 AM',
            },
            {
              'title': 'Palakkad Town Route 2',
              'schedule':
                  'Nila Gate: 7:55 AM → Kalleppulley 8:25 AM → Sahyadri 8:55 AM',
            },
            {
              'title': 'Palakkad Town Route 3',
              'schedule': 'Palakkad 8:00 AM → Sahyadri 8:30 AM',
            },
            {
              'title': 'Palakkad Town Route 4',
              'schedule':
                  'Sahyadri 5:10 PM → Palakkad 5:40 PM → Stadium 5:45 PM',
            },
            {
              'title': 'Palakkad Town Route 5',
              'schedule':
                  'Sahyadri 5:20 PM → Kalleppulley 5:55 PM → Nila',
            },
            {
              'title': 'Wise Park Junction Route 1',
              'schedule':
                  'Nila 8:15 AM → Wise Park 8:30 AM → Sahyadri 9:00 AM',
            },
            {
              'title': 'Wise Park Junction Route 2',
              'schedule':
                  'Sahyadri 6:15 PM → Wise Park 6:45 PM → Nila 7:00 PM',
            },
          ],
        ),
      ],
    );
  }
}

class _SaturdaySchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _RouteCard(
          title: 'Nila to Sahyadri',
          icon: Icons.arrow_forward,
          times: const [
            '9:00', '9:30', '10:00', '10:30', '11:00', '11:30', '12:00',
            '12:30', '1:00', '1:30', '2:00', '2:30', '3:00', '3:30',
            '4:00', '4:30', '5:00', '5:30', '6:00', '6:30', '7:00',
            '7:30', '8:00', '8:30', '9:00', '10:00', '11:00', '12:00',
          ],
        ),
        const SizedBox(height: 16),
        _RouteCard(
          title: 'Sahyadri to Nila',
          icon: Icons.arrow_back,
          times: const [
            '8:00', '8:30', '9:00', '9:30', '10:00', '10:30', '11:00',
            '11:30', '12:00', '12:30', '1:00', '1:30', '2:00', '2:30',
            '3:00', '3:30', '4:00', '4:30', '5:00', '5:30', '6:00',
            '6:30', '7:00', '7:30', '8:15', '9:15', '10:15', '11:15',
          ],
        ),
        const SizedBox(height: 16),
        _SpecialRoutesCard(
          routes: [
            {
              'title': 'Palakkad Town Routes',
              'schedule': 'Routes 1, 2, 4 from Working Days + Route 6',
            },
            {
              'title': 'Route 6',
              'schedule':
                  'Sahyadri 1:00 PM → Palakkad 1:30 PM → Nila/Saraswati 2:00 PM',
            },
            {
              'title': 'Wise Park Junction Route 1',
              'schedule':
                  'Nila 8:45 AM → Wise Park 9:00 AM → Sahyadri 9:30 AM',
            },
            {
              'title': 'Wise Park Junction Route 2',
              'schedule':
                  'Sahyadri 6:15 PM → Wise Park 6:45 PM → Nila 7:00 PM',
            },
          ],
        ),
      ],
    );
  }
}

class _SundaySchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _RouteCard(
          title: 'Nila to Sahyadri',
          icon: Icons.arrow_forward,
          times: const [
            '8:45', '10:00', '11:00', '12:00', '12:30', '1:15', '2:00',
            '3:00', '4:00', '5:00', '6:00', '6:30', '7:00', '7:30',
            '8:00', '8:30', '9:00', '10:00', '11:00', '12:00',
          ],
        ),
        const SizedBox(height: 16),
        _RouteCard(
          title: 'Sahyadri to Nila',
          icon: Icons.arrow_back,
          times: const [
            '8:00', '8:30', '9:00', '10:15', '11:15', '12:15', '12:45',
            '1:30', '2:15', '3:15', '4:15', '5:15', '6:00', '6:30',
            '7:00', '7:30', '8:15', '9:15', '10:15', '11:15',
          ],
        ),
        const SizedBox(height: 16),
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Note',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('No Palakkad Town buses on Sundays'),
                const Text('No Wise Park Junction buses on Sundays'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RouteCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> times;
  final String? note;

  const _RouteCard({
    required this.title,
    required this.icon,
    required this.times,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (note != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  note!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: times.map((time) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    time,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecialRoutesCard extends StatelessWidget {
  final List<Map<String, String>> routes;

  const _SpecialRoutesCard({required this.routes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.route, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Special Routes',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...routes.map((route) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route['title']!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      route['schedule']!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
