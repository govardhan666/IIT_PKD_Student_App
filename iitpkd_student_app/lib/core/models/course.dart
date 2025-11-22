import 'dart:convert';

class Course {
  final String courseCode;
  final String courseName;
  final String courseCategory;
  final String ltpc; // Lecture-Tutorial-Practical-Credits format (e.g., "3-0-2-4")
  final String slot;
  final String instructor;
  final String? room;
  final String? credits;

  Course({
    required this.courseCode,
    required this.courseName,
    required this.courseCategory,
    required this.ltpc,
    required this.slot,
    required this.instructor,
    this.room,
    this.credits,
  });

  // Parse L-T-P-C format to get credits
  int get totalCredits {
    if (credits != null) return int.tryParse(credits!) ?? 0;
    final parts = ltpc.split('-');
    if (parts.length >= 4) {
      return int.tryParse(parts[3]) ?? 0;
    }
    return 0;
  }

  // Get lecture hours
  int get lectureHours {
    final parts = ltpc.split('-');
    if (parts.isNotEmpty) {
      return int.tryParse(parts[0]) ?? 0;
    }
    return 0;
  }

  // Parse slot to get individual slots (e.g., "C + PA3" -> ["C", "PA3"])
  List<String> get individualSlots {
    return slot
        .split('+')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  Course copyWith({
    String? courseCode,
    String? courseName,
    String? courseCategory,
    String? ltpc,
    String? slot,
    String? instructor,
    String? room,
    String? credits,
  }) {
    return Course(
      courseCode: courseCode ?? this.courseCode,
      courseName: courseName ?? this.courseName,
      courseCategory: courseCategory ?? this.courseCategory,
      ltpc: ltpc ?? this.ltpc,
      slot: slot ?? this.slot,
      instructor: instructor ?? this.instructor,
      room: room ?? this.room,
      credits: credits ?? this.credits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseCode': courseCode,
      'courseName': courseName,
      'courseCategory': courseCategory,
      'ltpc': ltpc,
      'slot': slot,
      'instructor': instructor,
      'room': room,
      'credits': credits,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseCode: map['courseCode'] ?? '',
      courseName: map['courseName'] ?? '',
      courseCategory: map['courseCategory'] ?? '',
      ltpc: map['ltpc'] ?? '',
      slot: map['slot'] ?? '',
      instructor: map['instructor'] ?? '',
      room: map['room'],
      credits: map['credits'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));
}
