import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanchoy/data/models/ShowCustomerSupplierModel.dart';

class CustomerDetailsPage extends StatefulWidget {
  final String customerid;
  const CustomerDetailsPage({super.key, required this.customerid});

  @override
  CustomerDetailsPageState createState() => CustomerDetailsPageState();
}

class CustomerDetailsPageState extends State<CustomerDetailsPage>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  DateTime? _selectedDate;
  bool isLoading = true;
  List<Showcustomersuppliermodel> showOwnerdata = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Showcustomersuppliermodel> showCustomerData = [];
  List<Showcustomersuppliermodel> sortSelectedCustomerData = [];
  TextEditingController dueAmountTEController = TextEditingController();
  TextEditingController paidAmountTEController = TextEditingController();
  TextEditingController descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchOwnerdata();
    fetchCustomerdata();
  }

  Future<void> fetchOwnerdata() async {
    isLoading = true;
    setState(() {});
    try {
      final DocumentSnapshot doc =
          await db.collection('entries').doc(widget.customerid).get();
      if (doc.exists) {
        final Showcustomersuppliermodel showownermodel =
            Showcustomersuppliermodel.fromJson(
              doc.id,
              doc.data() as Map<String, dynamic>,
            );
        showOwnerdata.clear();
        showOwnerdata.add(showownermodel);
      } else {
        print("No document found with ID: ${widget.customerid}");
      }
    } catch (e) {
      print("Error fetching owner data: $e");
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> fetchCustomerdata() async {
    isLoading = true;
    setState(() {});

    final DocumentSnapshot doc =
        await db.collection('entries').doc(widget.customerid).get();
    final Showcustomersuppliermodel showownermodel =
        Showcustomersuppliermodel.fromJson(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
    showOwnerdata.clear();
    showOwnerdata.add(showownermodel);

    //Different Part

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
      if (showCustomerData[i].name == showOwnerdata[0].name &&
          showCustomerData[i].phone == showOwnerdata[0].phone) {
        sortSelectedCustomerData.add(showCustomerData[i]);
        print('object');
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff2370B4)),
            ),
            Positioned(
              top: 50,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/icons/Success Icon.png',
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Customer Details',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              right: 0,
              left: 0,
              child: Container(
                height: 810,
                decoration: BoxDecoration(
                  color: const Color(0xffE9F1F8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 285,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  showOwnerdata.isNotEmpty &&
                                          _shouldShowImage(
                                            showOwnerdata[0].photo,
                                          )
                                      ? MemoryImage(
                                        base64Decode(showOwnerdata[0].photo),
                                      )
                                      : null,
                            ),
                            title: Text(
                              showOwnerdata.isNotEmpty
                                  ? showOwnerdata[0].name
                                  : '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              showOwnerdata.isNotEmpty
                                  ? showOwnerdata[0].phone
                                  : '',
                              style: TextStyle(color: Color(0xff5B5B5B)),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 27,
                              width: 125,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xff5B5B5B),
                                    ),
                                  ),
                                  Text(
                                    showOwnerdata.isNotEmpty
                                        ? showOwnerdata[0].location
                                        : '',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xff5B5B5B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 244,
                      width: 380,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 450,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: dueAmountTEController,
                                    decoration: InputDecoration(
                                      hintText: 'Due amount',
                                      prefixIcon: Image.asset(
                                        'assets/icons/taka.png',
                                      ),
                                      hintStyle: TextStyle(
                                        color: Color(0xffE80000),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: TextFormField(
                                    controller: paidAmountTEController,
                                    decoration: InputDecoration(
                                      hintText: 'Paid amount',
                                      prefixIcon: Image.asset(
                                        'assets/icons/taka.png',
                                        color: Color(0xff007D00),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Color(0xff007D00),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionTEController,
                            decoration: InputDecoration(
                              hintText: 'Description',
                              prefixIcon: Image.asset(
                                'assets/icons/Description.png',
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: Image.asset(
                                    'assets/icons/uiw_date.png',
                                  ),
                                  label: Text(
                                    _selectedDate == null
                                        ? 'Pick Date'
                                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                  ),
                                  onPressed: _pickDate,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffBBD3E8),
                                    foregroundColor: Color(0xff000000),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 152),
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: Image.asset('assets/icons/capture.png'),
                                  label: const Text('Photo'),
                                  onPressed: onTapGetImage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffBBD3E8),
                                    foregroundColor: Color(0xff000000),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: Color(0xff2370B4),
                                foregroundColor: Color(0xffFFFFFF),
                              ),
                              child: Text(
                                'Confirm',
                                style: TextStyle(fontFamily: 'Poppins-Bold'),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: [
                          Text('Due:', style: TextStyle(fontSize: 16)),
                          Text(
                            '10',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffE80000),
                            ),
                          ),
                          Image.asset('assets/icons/taka1.png'),
                          SizedBox(width: 260),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Image.asset('assets/icons/download.png'),
                              label: const Text('Report'),
                              onPressed: onTapGetImage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffBBD3E8),
                                foregroundColor: Color(0xff000000),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .45,

                      // child: StreamBuilder<QuerySnapshot>(
                      //   stream:
                      //       FirebaseFirestore.instance
                      //           .collection('entries')
                      //           .snapshots(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return Center(child: CircularProgressIndicator());
                      //     }
                      //     final docs = snapshot.data!.docs;
                      child: ListView.builder(
                        itemCount: sortSelectedCustomerData.length,
                        itemBuilder: (context, index) {
                          return CustomerSingleTransection(
                            amount:
                                sortSelectedCustomerData[index].previousDue
                                    .toString(),
                            date: sortSelectedCustomerData[index].date,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _submitForm() async {
  //   if (dueAmountTEController.text.isEmpty || paidAmountTEController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Due or Paid amount are required")),
  //     );
  //     return;
  //   }

  //   String? photoUrl;
  //   if (_pickedImage != null) {
  //     List<int> imageBytes = await _pickedImage!.readAsBytes();
  //     String encodedImage = base64Encode(imageBytes);
  //     photoUrl = encodedImage;
  //   }

  //   String type = _tabController.index == 0 ? 'Customer' : 'Supplier';
  //   String location = _locationTEController.text.trim();

  //   Map<String, dynamic> data = {
  //     'name': _nameTEController.text.trim(),
  //     'phone': _phoneTEController.text.trim(),
  //     'location': location,
  //     'previous_due':
  //         double.tryParse(_previousDueTEController.text.trim()) ?? 0.0,
  //     'photo': photoUrl,
  //     'type': type,
  //     'selected_date':
  //         _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
  //   };

  //   try {
  //     await FirebaseFirestore.instance.collection('entries').add(data);

  //     showShackBarMessenger(context, "Entry added successfully", true);
  //     Navigator.of(context).pop();
  //   } catch (e) {
  //     showShackBarMessenger(context, "Failed to add entry: $e", false);
  //   }
  // }

  Future<void> onTapGetImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      XFile _pickedImage;
      setState(() {
        _pickedImage = image;
      });
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }
}

class CustomerSingleTransection extends StatelessWidget {
  const CustomerSingleTransection({
    super.key,
    required this.date,
    required this.amount,
  });
  final DateTime date;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('d/M/yy').format(date),
                style: TextStyle(color: Color(0xff5B5B5B)),
              ),
              SizedBox(width: 16),
              Text('Due', style: TextStyle(color: Color(0xffE80000))),
              SizedBox(width: 32),
              Image.asset('assets/icons/taka.png', color: Color(0xff5B5B5B)),
              SizedBox(width: 5),
              Text(amount, style: TextStyle(color: Color(0xff5B5B5B))),
              SizedBox(width: 32),
              Image.asset(
                'assets/icons/Description.png',
                color: Color(0xff5B5B5B),
              ),
              TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                child: Text(
                  'Details',
                  style: TextStyle(color: Color(0xff5B5B5B)),
                ),
              ),
            ],
          ),
          Container(height: 1.5, width: 500, color: Color(0xff5B5B5B)),
        ],
      ),
    );
  }
}








// CustomerSingleTransection(),
//                   CustomerSingleTransection(),
//                   CustomerSingleTransection(),
//                   CustomerSingleTransection(),
//                   CustomerSingleTransection(),
//                   CustomerSingleTransection(),


// Expanded(
//                     child: ListView.builder(
//                       itemCount: 10,
//                       itemBuilder: (context, index) {
//                         return CustomerSingleTransection();
//                       },
//                     ),
//                   ),