import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanchoy/data/models/ShowCustomerSupplierModel.dart';
import 'package:sanchoy/data/models/ShowOwnerModel.dart';
import 'package:sanchoy/ui/screans/Customer_Deatils.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';
import 'package:sanchoy/ui/screans/add_curstomer.dart';
import 'package:sanchoy/ui/widgets/MainBottomNavBar/CustomerListView.dart';
import 'package:sanchoy/ui/widgets/MainBottomNavBar/SearchBarSection.dart';
import 'package:sanchoy/ui/widgets/MainBottomNavBar/ShowOwnerPersonalData.dart';
import 'package:sanchoy/ui/widgets/MainBottomNavBar/TransectionSummaryOfStackHolder.dart';

class Mainbuttomnavscreen extends StatefulWidget {
  const Mainbuttomnavscreen({super.key});

  @override
  State<Mainbuttomnavscreen> createState() => _MainbuttomnavscreenState();
}

class _MainbuttomnavscreenState extends State<Mainbuttomnavscreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Showownermodel> showOwnerdata = [];
  DateTime date = DateTime.now();
  double customerDue = 0;
  double supplierDue = 0;
  TextEditingController searchCustomerTEController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String get searchTerm => searchCustomerTEController.text.trim();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 62,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0xff9ABDDD),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/Ellipse 1.png'),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              showOwnerdata.isNotEmpty
                                  ? '${showOwnerdata[1].firstName} ${showOwnerdata[1].lastName}'
                                  : '',
                              style: TextStyle(
                                color: Color(0xff2370B4),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              showOwnerdata.isNotEmpty
                                  ? showOwnerdata[1].mobileNumber
                                  : '',
                              style: TextStyle(
                                color: Color(0xff5B5B5B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _key,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: screenHeight,
                color: const Color(0xff2370B4),
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: ShowOwnerPersonalData(
                  showOwnerdata: showOwnerdata,
                  ontap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  date: date,
                ),
              ),
              Positioned(
                top: 100,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffE9F1F8),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Column(
                    children: [
                      TransectionSummaryofStakeholder(
                        supplierDue: supplierDue,
                        customerDue: customerDue,
                      ),
                      const SizedBox(height: 10),
                      SearchBarSection(controller: searchCustomerTEController),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 230, 0),
                        child: Text(
                          "কাস্টমার / সাপ্লায়ার",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 6),
                      CustomerListView(
                        searchTerm: searchTerm,
                        buildCustomerTile: _buildCustomerTile,
                      ),
                    ],
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

  Widget _buildCustomerTile(Showcustomersuppliermodel model, String id) {
    return GestureDetector(
      onTap: () => onTapCustomerDetails(id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              _shouldShowImage(model.photo)
                  ? MemoryImage(base64Decode(model.photo))
                  : null,
        ),
        title: Text(
          model.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(model.phone),
        trailing: Text(
          "৳${model.previousDue == 0 ? model.paidAmount.toStringAsFixed(2) : model.previousDue.toStringAsFixed(2)}",
          style: TextStyle(
            color: model.previousDue == 0 ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchOwnerdata();
    calculateDues();
    searchCustomerTEController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future<void> fetchOwnerdata() async {
    final QuerySnapshot snapshot = await db.collection('users').get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      Showownermodel model = Showownermodel.formJson(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
      showOwnerdata.add(model);
    }
    setState(() {});
  }

  Future<void> calculateDues() async {
    final QuerySnapshot snapshot = await db.collection('entries1').get();
    customerDue = 0;
    supplierDue = 0;
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      final model = Showcustomersuppliermodel.fromJson(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
      customerDue += model.previousDue;
      supplierDue += model.paidAmount;
    }
    setState(() {});
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
