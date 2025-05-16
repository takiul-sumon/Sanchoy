import 'package:cloud_firestore/cloud_firestore.dart';

class Showownermodel {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final DateTime createdDate;
  Showownermodel({
    required this.firstName,
    required this.lastName,
    required this.createdDate,
    required this.mobileNumber,
  });

  factory Showownermodel.formJson(String docId, Map<String, dynamic> jsonData) {
    return Showownermodel(
      firstName: jsonData['firstName'] ?? '',
      lastName: jsonData['lastName'] ?? '',
      createdDate:
          (jsonData['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      mobileNumber: jsonData['mobile'] ?? '',
    );
  }
}
