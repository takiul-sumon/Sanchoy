import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanchoy/data/models/ShowCustomerSupplierModel.dart';
import 'package:sanchoy/ui/screans/Customer_Deatils.dart';
import 'package:sanchoy/ui/screans/add_curstomer.dart';

class Mainbuttomnavscreen extends StatefulWidget {
  const Mainbuttomnavscreen({super.key});

  @override
  State<Mainbuttomnavscreen> createState() => _MainbuttomnavscreenState();
}

class _MainbuttomnavscreenState extends State<Mainbuttomnavscreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: screenHeight,
              decoration: const BoxDecoration(color: Color(0xff2370B4)),
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Monir Tea Stall',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '04 March, 2025',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        icon: Image.asset('assets/icons/Language Switch.png'),
                      ),
                      SizedBox(width: 6),
                      IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        icon: Image.asset(
                          'assets/icons/Notification Icon Container.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 120,
              right: 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffE9F1F8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: const [
                              Text(
                                "মোট পাবে",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "৳50.00",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 40, width: 1, color: Colors.grey),
                          Column(
                            children: const [
                              Text(
                                "মোট দেবে",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "৳50.00",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "খোঁজ",
                                    prefixIcon: const Icon(Icons.search),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                color: Colors.grey,
                                icon: Image.asset('assets/icons/Filter.png'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                color: Colors.grey,
                                icon: Image.asset(
                                  'assets/icons/Download Icon.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 230, 0),
                        child: Text(
                          "কাস্টমার / সাপ্লায়ার",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .9,
                        child: StreamBuilder<QuerySnapshot>(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('entries')
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(child: Text('No data found'));
                            }

                            final docs = snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final doc = docs[index];
                                final model =
                                    Showcustomersuppliermodel.fromJson(
                                      doc.id,
                                      doc.data() as Map<String, dynamic>,
                                    );

                                return GestureDetector(
                                  onTap: onTapCustomerDetails,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          _shouldShowImage(model.photo)
                                              ? MemoryImage(
                                                base64Decode(model.photo),
                                              )
                                              : null,
                                    ),
                                    title: Text(model.name),
                                    subtitle: Text(model.date.toString()),
                                    trailing: Text(
                                      "৳${model.previousDue}.00",
                                      style: TextStyle(
                                        color:
                                            index % 2 == 0
                                                ? Colors.green
                                                : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onTapAddCustomerSupplier,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            onPressed: onTapAddCustomerSupplier,
            icon: Image.asset('assets/icons/Group.png'),
          ),
        ),
      ),
    );
  }

  void onTapAddCustomerSupplier() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddCustomerSupplierPage()));
  }

  void onTapCustomerDetails() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => CustomerDetailsPage()));
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }
}
