import '../models/course.dart';
import '../models/timetable_entry.dart';

class TimetableGenerator {
  // Slot timings for each day
  static const Map<String, Map<String, Map<String, String>>> slotTimings = {
    'Monday': {
      'A': {'start': '08:00', 'end': '08:50'},
      'B': {'start': '09:00', 'end': '09:50'},
      'C': {'start': '10:00', 'end': '10:50'},
      'D': {'start': '11:00', 'end': '11:50'},
      'H': {'start': '12:05', 'end': '12:55'},
      'I': {'start': '14:00', 'end': '15:15'},
      'J': {'start': '15:30', 'end': '16:45'},
      'R1': {'start': '17:10', 'end': '18:00'},
      'PM1': {'start': '09:00', 'end': '11:45'},
      'PA1': {'start': '14:00', 'end': '16:45'},
    },
    'Tuesday': {
      'B': {'start': '08:00', 'end': '08:50'},
      'F': {'start': '09:00', 'end': '10:15'},
      'G': {'start': '10:30', 'end': '11:45'},
      'M': {'start': '12:00', 'end': '12:50'},
      'K': {'start': '14:00', 'end': '15:15'},
      'L': {'start': '15:30', 'end': '16:45'},
      'R2': {'start': '17:10', 'end': '18:00'},
      'PM2': {'start': '09:00', 'end': '11:45'},
      'PA2': {'start': '14:00', 'end': '16:45'},
    },
    'Wednesday': {
      'C': {'start': '08:00', 'end': '08:50'},
      'D': {'start': '09:00', 'end': '09:50'},
      'E': {'start': '10:00', 'end': '10:50'},
      'A': {'start': '11:00', 'end': '11:50'},
      'H': {'start': '12:05', 'end': '12:55'},
      'Q': {'start': '14:00', 'end': '14:50'},
      'R3': {'start': '15:00', 'end': '15:50'},
      'CMN-A': {'start': '16:00', 'end': '16:50'},
      'CMN-B': {'start': '17:00', 'end': '17:50'},
      'PM3': {'start': '09:00', 'end': '11:45'},
      'PA3': {'start': '14:00', 'end': '15:50'},
      'EML': {'start': '17:10', 'end': '18:00'},
    },
    'Thursday': {
      'D': {'start': '08:00', 'end': '08:50'},
      'G': {'start': '09:00', 'end': '10:15'},
      'F': {'start': '10:30', 'end': '11:45'},
      'M': {'start': '12:00', 'end': '12:50'},
      'L': {'start': '14:00', 'end': '15:15'},
      'K': {'start': '15:30', 'end': '16:45'},
      'R4': {'start': '17:10', 'end': '18:00'},
      'PM4': {'start': '09:00', 'end': '11:45'},
      'PA4': {'start': '14:00', 'end': '16:45'},
    },
    'Friday': {
      'E': {'start': '08:00', 'end': '08:50'},
      'A': {'start': '09:00', 'end': '09:50'},
      'B': {'start': '10:00', 'end': '10:50'},
      'C': {'start': '11:00', 'end': '11:50'},
      'H': {'start': '12:05', 'end': '12:55'},
      'J': {'start': '14:00', 'end': '15:15'},
      'I': {'start': '15:30', 'end': '16:45'},
      'R5': {'start': '17:10', 'end': '18:00'},
      'PM5': {'start': '09:00', 'end': '11:45'},
      'PA5': {'start': '14:00', 'end': '16:45'},
    },
  };

  static const List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  /// Generate timetable from courses
  static Timetable generateTimetable(
    List<Course> courses,
    String semester,
  ) {
    final List<TimetableEntry> entries = [];

    // For each course, find its slots in the week
    for (final course in courses) {
      final courseSlots = course.individualSlots;

      for (final slotName in courseSlots) {
        // Find this slot in the weekly schedule
        for (final day in weekDays) {
          final daySlots = slotTimings[day];
          if (daySlots != null && daySlots.containsKey(slotName)) {
            final timing = daySlots[slotName]!;
            final isLab = slotName.startsWith('PM') || slotName.startsWith('PA');

            entries.add(
              TimetableEntry(
                day: day,
                slotName: slotName,
                startTime: timing['start']!,
                endTime: timing['end']!,
                course: course,
                isLab: isLab,
              ),
            );
          }
        }
      }
    }

    // Sort entries by day and time
    entries.sort((a, b) {
      final dayComparison = weekDays.indexOf(a.day).compareTo(weekDays.indexOf(b.day));
      if (dayComparison != 0) return dayComparison;
      return a.startTime.compareTo(b.startTime);
    });

    return Timetable(
      semester: semester,
      entries: entries,
    );
  }

  /// Get today's classes
  static List<TimetableEntry> getTodayClasses(Timetable timetable) {
    final now = DateTime.now();
    final dayName = weekDays[now.weekday - 1]; // Monday is 1 in DateTime

    if (now.weekday > 5) {
      // Weekend - no classes
      return [];
    }

    return timetable.getEntriesForDay(dayName);
  }

  /// Get upcoming class
  static TimetableEntry? getUpcomingClass(Timetable timetable) {
    final todayClasses = getTodayClasses(timetable);
    if (todayClasses.isEmpty) return null;

    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    // Find first class that hasn't ended yet
    for (final entry in todayClasses) {
      if (entry.endTime.compareTo(currentTime) > 0) {
        return entry;
      }
    }

    return null; // All classes done for today
  }

  /// Check if currently in a class
  static TimetableEntry? getCurrentClass(Timetable timetable) {
    final todayClasses = getTodayClasses(timetable);
    if (todayClasses.isEmpty) return null;

    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    // Find class that is currently ongoing
    for (final entry in todayClasses) {
      if (entry.startTime.compareTo(currentTime) <= 0 &&
          entry.endTime.compareTo(currentTime) > 0) {
        return entry;
      }
    }

    return null;
  }
}
