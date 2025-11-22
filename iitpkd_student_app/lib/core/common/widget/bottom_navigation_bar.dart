import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../features/home/view/pages/home_page.dart';
import '../../../features/timetable/view/pages/timetable_page.dart';
import '../../../features/bus_schedule/view/pages/bus_schedule_page.dart';
import '../../../features/mess_menu/view/pages/mess_menu_page.dart';
import '../../../features/account/view/pages/account_page.dart';

// Bottom nav index provider
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class AppBottomNavigationBar extends ConsumerStatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  ConsumerState<AppBottomNavigationBar> createState() =>
      _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState
    extends ConsumerState<AppBottomNavigationBar> {
  final List<Widget> _pages = const [
    HomePage(),
    TimetablePage(),
    BusSchedulePage(),
    MessMenuPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          ref.read(bottomNavIndexProvider.notifier).state = 0;
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _pages[currentIndex],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            ref.read(bottomNavIndexProvider.notifier).state = index;
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home_copy),
              selectedIcon: Icon(Iconsax.home_1_copy),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.calendar_copy),
              selectedIcon: Icon(Iconsax.calendar_1_copy),
              label: 'Timetable',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.bus_copy),
              selectedIcon: Icon(Iconsax.bus_copy),
              label: 'Bus',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.book_copy),
              selectedIcon: Icon(Iconsax.book_1_copy),
              label: 'Mess',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user_copy),
              selectedIcon: Icon(Iconsax.user_copy),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
