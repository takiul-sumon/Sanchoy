
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanchoy/data/models/ShowCustomerSupplierModel.dart';

class CustomerListView extends StatelessWidget {
  final String searchTerm;
  final Widget Function(Showcustomersuppliermodel model, String docId)
      buildCustomerTile;

  const CustomerListView({
    super.key,
    required this.searchTerm,
    required this.buildCustomerTile,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: searchTerm.isEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('entries1')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data found'));
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final model = Showcustomersuppliermodel.fromJson(
                      doc.id,
                      doc.data() as Map<String, dynamic>,
                    );
                    return buildCustomerTile(model, doc.id);
                  },
                );
              },
            )
          : FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('entries1')
                  .where('phone', isEqualTo: searchTerm)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No matching data found'));
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final model = Showcustomersuppliermodel.fromJson(
                      doc.id,
                      doc.data() as Map<String, dynamic>,
                    );
                    return buildCustomerTile(model, doc.id);
                  },
                );
              },
            ),
    );
  }
}




