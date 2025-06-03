import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanchoy/data/models/ShowCustomerSupplierModel.dart';
import 'package:sanchoy/data/models/ShowOwnerModel.dart';
import 'package:sanchoy/ui/screans/Customer_Deatils.dart';
import 'package:sanchoy/ui/screans/add_curstomer.dart';

class Mainbuttomnavscreen extends StatefulWidget {
  const Mainbuttomnavscreen({super.key});

  @override
  State<Mainbuttomnavscreen> createState() => _MainbuttomnavscreenState();
}

class _MainbuttomnavscreenState extends State<Mainbuttomnavscreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Showownermodel> showOwnerdata = [];
  List<Showcustomersuppliermodel> showCustomerData = [];
  bool isLoading = true;
  DateTime date = DateTime.now();
  int customerDue = 0;
  int supplierDue = 0;
  TextEditingController searchCustomerTEController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    fetchOwnerdata();
    fetchCustomerdata();
    super.initState();
  }

  Future<void> fetchOwnerdata() async {
    isLoading = true;
    setState(() {});
    final QuerySnapshot snapshot = await db.collection('users').get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      Showownermodel showownermodel = Showownermodel.formJson(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
      showOwnerdata.add(showownermodel);
    }

    print(showOwnerdata);
    isLoading = false;
    setState(() {});
  }

  Future<void> fetchCustomerdata() async {
    isLoading = true;
    setState(() {});
    final QuerySnapshot snapshot = await db.collection('entries').get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      Showcustomersuppliermodel showcustomermodel =
          Showcustomersuppliermodel.fromJson(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
      showCustomerData.add(showcustomermodel);
    }
    for (int i = 0; i < showCustomerData.length; i++) {
      if (showCustomerData[i].relationType == 'Customer') {
        customerDue = customerDue + showCustomerData[i].previousDue;
      } else {
        supplierDue += showCustomerData[i].previousDue;
      }
    }

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: screenHeight,
                decoration: const BoxDecoration(color: Color(0xff2370B4)),
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          showOwnerdata.isNotEmpty
                              ? '${showOwnerdata[0].firstName} ${showOwnerdata[0].lastName}'
                              : '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMEd().format(date),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: Image.asset('assets/icons/Language Switch.png'),
                        ),
                        const SizedBox(width: 6),
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
                top: 100,
                right: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffE9F1F8),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "মোট পাবে",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "৳$supplierDue",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                              width: 40,
                            ),
                            Column(
                              children: [
                                Text(
                                  "মোট দেবে",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "৳$customerDue",
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
                                    controller: searchCustomerTEController,
                                    decoration: InputDecoration(
                                      hintText: "খোঁজ",
                                      prefixIcon: const Icon(Icons.search),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    validator: (String? value) {
                                      String searchCustomerDetails = value!;
                                      if (searchCustomerDetails.isEmpty) {
                                        return 'Enter A Valid Customer';
                                      }
                                      return null;
                                    },
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
                          height: MediaQuery.of(context).size.height * 0.9,
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
                                return const Center(
                                  child: Text('No data found'),
                                );
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
                                    onTap: () => onTapCustomerDetails(doc.id),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            _shouldShowImage(model.photo)
                                                ? MemoryImage(
                                                  base64Decode(model.photo),
                                                )
                                                : null,
                                      ),
                                      title: Text(
                                        model.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(model.phone),
                                      trailing: Text(
                                        "৳${model.previousDue}.00",
                                        style: TextStyle(
                                          color:
                                              model.relationType == 'Customer'
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapAddCustomerSupplier,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: IconButton(
          onPressed: onTapAddCustomerSupplier,
          icon: Image.asset('assets/icons/Group.png'),
        ),
      ),
    );
  }

  void onTapAddCustomerSupplier() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddCustomerSupplierPage()),
    );
  }

  void onTapCustomerDetails(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomerDetailsPage(customerid: id),
      ),
    );
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }
}
