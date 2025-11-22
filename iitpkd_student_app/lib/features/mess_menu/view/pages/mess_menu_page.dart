import 'package:flutter/material.dart';

class MessMenuPage extends StatefulWidget {
  const MessMenuPage({super.key});

  @override
  State<MessMenuPage> createState() => _MessMenuPageState();
}

class _MessMenuPageState extends State<MessMenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _currentWeek;

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    final today = DateTime.now().weekday - 1; // Monday = 0
    _tabController = TabController(
      length: _days.length,
      vsync: this,
      initialIndex: today,
    );

    // Determine current week (1&3 or 2&4)
    final weekOfMonth = ((DateTime.now().day - 1) / 7).floor() + 1;
    _currentWeek = (weekOfMonth % 2 == 1) ? 'Week 1 & 3' : 'Week 2 & 4';
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
        title: const Text('Mess Menu'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Current: $_currentWeek',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: _days.map((day) => Tab(text: day)).toList(),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _days.map((day) => _buildDayMenu(day)).toList(),
      ),
    );
  }

  Widget _buildDayMenu(String day) {
    final menu = _getMenuForDay(day);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _MealCard(
          mealType: 'Breakfast',
          icon: Icons.free_breakfast,
          color: Colors.orange,
          items: menu['breakfast']!,
        ),
        const SizedBox(height: 16),
        _MealCard(
          mealType: 'Lunch',
          icon: Icons.lunch_dining,
          color: Colors.green,
          items: menu['lunch']!,
        ),
        const SizedBox(height: 16),
        _MealCard(
          mealType: 'Snacks',
          icon: Icons.cookie,
          color: Colors.purple,
          items: menu['snacks']!,
        ),
        const SizedBox(height: 16),
        _MealCard(
          mealType: 'Dinner',
          icon: Icons.dinner_dining,
          color: Colors.blue,
          items: menu['dinner']!,
        ),
      ],
    );
  }

  Map<String, List<String>> _getMenuForDay(String day) {
    // Week 1 & 3 menu
    final week13Menu = {
      'Monday': {
        'breakfast': [
          'Aloo paratha',
          'Ketchup',
          'Curd',
          'Mint & Coriander Chutney',
        ],
        'lunch': [
          'Phulka',
          'White Rice',
          'Kerala Rice',
          'Chana Masala',
          'Arhar dal (pigeon pea)',
          'Curd',
        ],
        'snacks': [
          'Onion kachori',
          'Tomato ketchup',
          'Fried chilly',
        ],
        'dinner': [
          'NON-VEG: Egg Fried Rice',
          'VEG: Gobhi Fried Rice',
          'Phulka',
          'Dal Tadka',
          'Garlic Sauce',
        ],
      },
      'Tuesday': {
        'breakfast': [
          'Masala Dosa',
          'Tomato Chutney',
          'Sambar',
        ],
        'lunch': [
          'Puri',
          'Aloo Palak',
          'Sambar',
          'Ridge Gourd(dry)',
          'White Rice',
          'Buttermilk',
          'Seasonal fruit(watermelon)',
          'Kerala rice',
        ],
        'snacks': [
          'Aloo Bonda',
          'Tomato ketchup',
        ],
        'dinner': [
          'Phulka',
          'Chole Masala',
          'Jeera Rice',
          'Dal',
          'Raita Plain',
          'Icecream',
        ],
      },
      'Wednesday': {
        'breakfast': [
          'Dal Kitchdi',
          'Coconut Chutney',
          'Dahi Boondhi (small cup)',
          'PEANUT BUTTER',
          'NON VEG: Omlet',
        ],
        'lunch': [
          'Chapathi',
          'White Rice',
          'Green peas masala',
          'Tomato Rice',
          'Onion Raita(thick)',
          'Rasam',
          'Chana Dal Fry',
        ],
        'snacks': [
          'Masala Channa',
        ],
        'dinner': [
          'VEG: Hyderabadi Paneer Dish',
          'NON-VEG: Hyderabadi Style Chicken masala',
          'White rice',
          'Moong dal',
          'Lachcha Paratha',
          'Laddu',
          'Lemon',
        ],
      },
      'Thursday': {
        'breakfast': [
          'Puri',
          'Chana Masala',
        ],
        'lunch': [
          'Chapathi',
          'White Rice',
          'Mix Dal',
          'Gobhi Butter Masala',
          'Bottle Gourd Dry',
          'Curd',
        ],
        'snacks': [
          'Tikki chat',
        ],
        'dinner': [
          'Sambar',
          'Masala Dosa (UNLIMITED)',
          'White Rice',
          'Tomato Chutney / Coriander Chutney',
          'Payasam',
          'Rasam',
        ],
      },
      'Friday': {
        'breakfast': [
          'Fried Idly',
          'Vada',
          'Sambar',
          'Coconut chutney',
          'NON VEG: Omlet',
        ],
        'lunch': [
          'Phulka',
          'White Rice',
          'Kadai Veg',
          'Sambar',
          'Potato Cabbage Dry',
          'Buttermilk',
        ],
        'snacks': [
          'Pungulu with coconut chutney',
        ],
        'dinner': [
          'NON VEG: Chicken Gravy',
          'VEG: Paneer Butter masala',
          'Pulao',
          'Mix dal',
          'Chapathi',
          'Mango pickle',
          'Lemon',
          'Jalebi',
        ],
      },
      'Saturday': {
        'breakfast': [
          'Gobi Mix Veg Paratha',
          'Ketchup',
          'Green Coriander chutney',
          'Peanut Butter',
        ],
        'lunch': [
          'Chapathi',
          'White Rice',
          'Rajma Masala',
          'Green Vegetable (Dry)',
          'Ginger Dal',
          'Gongura chutney',
          'Curd',
        ],
        'snacks': [
          'Samosa',
          'Tomato ketchup',
          'Cold Coffee',
        ],
        'dinner': [
          'Phulka',
          'Green Peas Masala',
          'White Rice',
          'Brinjal Curry',
          'Rasam',
        ],
      },
      'Sunday': {
        'breakfast': [
          'Onion Rava dosa',
          'Tomato chutney',
          'Sambhar',
        ],
        'lunch': [
          'NON-VEG: Chicken Dum Briyani',
          'VEG: Paneer Dum Briyani',
          'Shorba Masala',
          'Onion Raita Thick',
          'Aam panna',
        ],
        'snacks': [
          'Vada Pav',
          'Fried Green Chilly',
          'Green coriander chutney',
        ],
        'dinner': [
          'Arhar Dal Tadka',
          'Aloo fry',
          'Kadhi Pakoda',
          'Rice',
          'Chapati',
          'Gulab Jamun',
        ],
      },
    };

    // Return menu for the day
    return week13Menu[day]!;
  }
}

class _MealCard extends StatelessWidget {
  final String mealType;
  final IconData icon;
  final Color color;
  final List<String> items;

  const _MealCard({
    required this.mealType,
    required this.icon,
    required this.color,
    required this.items,
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
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Text(
                  mealType,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) {
              final isNonVeg = item.toUpperCase().contains('NON-VEG') ||
                  item.toUpperCase().contains('CHICKEN') ||
                  item.toUpperCase().contains('EGG');

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isNonVeg ? Colors.red : Colors.green,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isNonVeg ? Colors.red : Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: theme.textTheme.bodyMedium,
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
