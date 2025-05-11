import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanchoy/data/models/ShowCustomerSupplierModel.dart';
import 'package:sanchoy/ui/screans/add_curstomer.dart';

class Mainbuttomnavscreen extends StatefulWidget {
  const Mainbuttomnavscreen({super.key});

  @override
  State<Mainbuttomnavscreen> createState() => _MainbuttomnavscreenState();
}

class _MainbuttomnavscreenState extends State<Mainbuttomnavscreen> {
  List<Showcustomersuppliermodel> showSupplierCustomer = [];
  bool isLoading = false;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final QuerySnapshot snapshot = await db.collection('entries').get();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Showcustomersuppliermodel addSupplierCustomer =
            Showcustomersuppliermodel.fromJson(
              doc.id,
              doc.data() as Map<String, dynamic>,
            );
        showSupplierCustomer.add(addSupplierCustomer);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    setState(() {
      isLoading = false; // ✅ Correct assignment
    });
  }

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
              decoration: BoxDecoration(color: Color(0xff2370B4)),
              padding: EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                decoration: BoxDecoration(
                  color: Color(0xffE9F1F8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          // borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                // Icon(Icons.arrow_downward, color: Colors.red),
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
                              children: [
                                // Icon(Icons.arrow_upward, color: Colors.green),
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
                      ),
                      SizedBox(height: 10),

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
                                      offset: Offset(0, 3), // shadow position
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "খোঁজ",
                                    prefixIcon: Icon(Icons.search),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
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
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                color: Colors.grey,
                                icon: Image.asset('assets/icons/Filter.png'),
                              ),
                            ),
                            SizedBox(width: 8),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 230, 0),
                        child: Text(
                          "কাস্টমার / সাপ্লায়ার",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .9,
                        child: Visibility(
                          visible: isLoading == false,
                          replacement: CircularProgressIndicator(),
                          child: ListView.builder(
                            itemCount: showSupplierCustomer.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      _shoidlShowImage(
                                            showSupplierCustomer[index].photo,
                                          )
                                          ? MemoryImage(
                                            base64Decode(
                                              showSupplierCustomer[index].photo,
                                            ),
                                          )
                                          : null,
                                ),
                                title: Text(showSupplierCustomer[index].name),
                                subtitle: Text(
                                  showSupplierCustomer[index].date.toString(),
                                ),
                                trailing: Text(
                                  "৳${showSupplierCustomer[index].previousDue}.00",
                                  style: TextStyle(
                                    color:
                                        index % 2 == 0
                                            ? Colors.green
                                            : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
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
          onPressed: () {},
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

  onTapAddCustomerSupplier() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddCustomerSupplierPage();
        },
      ),
    );
  }

  bool _shoidlShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }
}
