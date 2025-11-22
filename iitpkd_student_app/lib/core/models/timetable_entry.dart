import 'dart:convert';
import 'course.dart';

class TimetableEntry {
  final String day; // Monday, Tuesday, etc.
  final String slotName; // A, B, C, PM1, PA1, etc.
  final String startTime; // 08:00
  final String endTime; // 08:50
  final Course? course; // null if no class scheduled
  final String? room;
  final bool isLab; // true for PM/PA slots

  TimetableEntry({
    required this.day,
    required this.slotName,
    required this.startTime,
    required this.endTime,
    this.course,
    this.room,
    this.isLab = false,
  });

  bool get hasClass => course != null;

  // Check if this is a lunch break
  bool get isLunchBreak => startTime == '13:00' && endTime == '13:50';

  TimetableEntry copyWith({
    String? day,
    String? slotName,
    String? startTime,
    String? endTime,
    Course? course,
    String? room,
    bool? isLab,
  }) {
    return TimetableEntry(
      day: day ?? this.day,
      slotName: slotName ?? this.slotName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      course: course ?? this.course,
      room: room ?? this.room,
      isLab: isLab ?? this.isLab,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'slotName': slotName,
      'startTime': startTime,
      'endTime': endTime,
      'course': course?.toMap(),
      'room': room,
      'isLab': isLab,
    };
  }

  factory TimetableEntry.fromMap(Map<String, dynamic> map) {
    return TimetableEntry(
      day: map['day'] ?? '',
      slotName: map['slotName'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      course: map['course'] != null ? Course.fromMap(map['course']) : null,
      room: map['room'],
      isLab: map['isLab'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimetableEntry.fromJson(String source) =>
      TimetableEntry.fromMap(json.decode(source));
}

class Timetable {
  final String semester;
  final List<TimetableEntry> entries;

  Timetable({
    required this.semester,
    required this.entries,
  });

  // Get entries for a specific day
  List<TimetableEntry> getEntriesForDay(String day) {
    return entries.where((e) => e.day == day).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  // Get all days with classes
  List<String> get daysWithClasses {
    return entries.map((e) => e.day).toSet().toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'semester': semester,
      'entries': entries.map((x) => x.toMap()).toList(),
    };
  }

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      semester: map['semester'] ?? '',
      entries: List<TimetableEntry>.from(
        map['entries']?.map((x) => TimetableEntry.fromMap(x)) ?? [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Timetable.fromJson(String source) =>
      Timetable.fromMap(json.decode(source));
}
