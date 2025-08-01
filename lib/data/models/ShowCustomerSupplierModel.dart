import 'package:cloud_firestore/cloud_firestore.dart';

class Showcustomersuppliermodel {
  final String title;
  final String location;
  final String name;
  final String phone;
  final String photo;
  final double previousDue;
  final double paidAmount;

  final DateTime date;
  final String relationType;

  Showcustomersuppliermodel({
    required this.title,
    required this.location,
    required this.name,
    required this.photo,
    required this.previousDue,
    required this.paidAmount,
    required this.date,
    required this.phone,
    required this.relationType,
  });

  factory Showcustomersuppliermodel.fromJson(
    String docId,
    Map<String, dynamic> jsonData,
  ) {
    return Showcustomersuppliermodel(
      title: docId,
      location: jsonData['location'] ?? '',
      name: jsonData['name'] ?? '',
      photo: jsonData['photo'] ?? '',
      previousDue: (jsonData['previous_due'] ?? 0).toDouble(),
      paidAmount: (jsonData['paid_amount'] ?? 0).toDouble(),
      date:
          (jsonData['selected_date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      phone: jsonData['phone'] ?? '',
      relationType: jsonData['type'] ?? '',
    );
  }
}
