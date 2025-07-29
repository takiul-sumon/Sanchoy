import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      mobile: data['mobile'] ?? '',
    );
  }

  factory AppUser.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      mobile: data['mobile'] ?? '',
    );
  }
}
