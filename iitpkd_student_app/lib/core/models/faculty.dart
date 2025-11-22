import 'dart:convert';

class Faculty {
  final String name;
  final String designation;
  final String department;
  final String? email;
  final String? phone;
  final String? profileUrl;
  final String? imageUrl;
  final String? researchInterests;

  Faculty({
    required this.name,
    required this.designation,
    required this.department,
    this.email,
    this.phone,
    this.profileUrl,
    this.imageUrl,
    this.researchInterests,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'designation': designation,
      'department': department,
      'email': email,
      'phone': phone,
      'profileUrl': profileUrl,
      'imageUrl': imageUrl,
      'researchInterests': researchInterests,
    };
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      department: map['department'] ?? '',
      email: map['email'],
      phone: map['phone'],
      profileUrl: map['profileUrl'],
      imageUrl: map['imageUrl'],
      researchInterests: map['researchInterests'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source));
}
