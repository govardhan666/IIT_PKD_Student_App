import 'dart:convert';

class User {
  final String username;
  final String name;
  final String rollNumber;
  final String email;
  final String? department;
  final String? program;
  final String? batch;
  final String? phoneNumber;
  final String? profileImage;

  User({
    required this.username,
    required this.name,
    required this.rollNumber,
    required this.email,
    this.department,
    this.program,
    this.batch,
    this.phoneNumber,
    this.profileImage,
  });

  User copyWith({
    String? username,
    String? name,
    String? rollNumber,
    String? email,
    String? department,
    String? program,
    String? batch,
    String? phoneNumber,
    String? profileImage,
  }) {
    return User(
      username: username ?? this.username,
      name: name ?? this.name,
      rollNumber: rollNumber ?? this.rollNumber,
      email: email ?? this.email,
      department: department ?? this.department,
      program: program ?? this.program,
      batch: batch ?? this.batch,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'rollNumber': rollNumber,
      'email': email,
      'department': department,
      'program': program,
      'batch': batch,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      rollNumber: map['rollNumber'] ?? '',
      email: map['email'] ?? '',
      department: map['department'],
      program: map['program'],
      batch: map['batch'],
      phoneNumber: map['phoneNumber'],
      profileImage: map['profileImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
