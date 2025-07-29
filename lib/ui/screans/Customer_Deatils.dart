import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanchoy/data/models/ShowCustomerSupplierModel.dart';
import 'package:sanchoy/ui/screans/bottom_navigation_bar.dart';
import 'package:sanchoy/ui/widgets/SnackBarMessenger.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
  List<Showcustomersuppliermodel> showOwnerdata = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Showcustomersuppliermodel> showCustomerData = [];
  List<Showcustomersuppliermodel> sortSelectedCustomerData = [];
  final TextEditingController _previousDueTEController =
      TextEditingController();
  TextEditingController paidAmountTEController = TextEditingController();
  TextEditingController descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  double customerDue = 0;
  double supplierDue = 0;
  double netAmount = 0;

  @override
  void initState() {
    super.initState();
    fetchOwnerdata();
    fetchCustomerdata();
  }

  Future<void> fetchOwnerdata() async {
    setState(() {});
    try {
      final DocumentSnapshot doc =
          await db.collection('entries1').doc(widget.customerid).get();
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
    setState(() {});
  }

  Future<void> fetchCustomerdata() async {
    final DocumentSnapshot doc =
        await db.collection('entries1').doc(widget.customerid).get();
    final Showcustomersuppliermodel showownermodel =
        Showcustomersuppliermodel.fromJson(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
    showOwnerdata.clear();
    showOwnerdata.add(showownermodel);

    //Different Part

    final QuerySnapshot snapshot = await db.collection('entries1').get();
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
      }
    }
    for (int i = 0; i < sortSelectedCustomerData.length; i++) {
      if (sortSelectedCustomerData[i].paidAmount != 0) {
        customerDue += sortSelectedCustomerData[i].paidAmount;
      } else {
        supplierDue += sortSelectedCustomerData[i].previousDue;
      }
    }
    netAmount = customerDue - supplierDue;
    setState(() {});
  }


Future<void> generatePdfReport({
  required BuildContext context,
  required String userName,
  required String userPhone,
  required List<Map<String, dynamic>> transactions,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Text('Customer Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 20),
        pw.Text('Name: $userName', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Phone: $userPhone', style: pw.TextStyle(fontSize: 16)),
        pw.SizedBox(height: 20),
        pw.Text('Transactions:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        ...transactions.map((entry) {
          final String date = entry['date'] ?? 'N/A';
          final String paid = (entry['paidAmount'] ?? 0) != 0 ? 'Paid: ${entry['paidAmount']}' : '';
          final String due = (entry['previousDue'] ?? 0) != 0 ? 'Due: ${entry['previousDue']}' : '';
          final String description = entry['description'] ?? '';
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Text(
              'Date: $date | $paid $due | $description',
              style: pw.TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}



  Future<void> deleteCustomerAndRelatedEntries() async {
    try {
      // Delete all transactions related to the customer
      final transactionsSnapshot =
          await FirebaseFirestore.instance
              .collection('transactions')
              .where('customerId', isEqualTo: widget.customerid)
              .get();

      for (var doc in transactionsSnapshot.docs) {
        await doc.reference.delete();
      }

      await FirebaseFirestore.instance
          .collection('entries1')
          .doc(widget.customerid)
          .delete();

      // Show success message
      showShackBarMessenger(context, "Customer and all transactions deleted.");

      // Navigate back
      Navigator.of(context).pop();
    } catch (e) {
      print('Error deleting customer: $e');
      showShackBarMessenger(context, "Error deleting customer.", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                decoration: const BoxDecoration(color: Color(0xff2370B4)),
              ),
              Positioned(
                top: 20,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return BottomNaviationBar();
                            },
                          ),
                        );
                      },
                      icon: Image.asset(
                        'assets/icons/Success Icon.png',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      showOwnerdata.isNotEmpty
                          ? showOwnerdata[0].relationType == 'Customer'
                              ? 'Customer Details'
                              : 'Supplier Details'
                          : '',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 70,
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
                            children: [
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          color: Color(0xffE9F1F8),
                                          height: 150,
                                          width: 390,
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.warning_outlined,
                                                color: Color(0xff2388FF),
                                                size: 25,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Delete Customer',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0xff0F2F4C),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Are you sure you want to delete ',
                                                    style: TextStyle(
                                                      color: Color(0xff0F2F4C),
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),

                                                  Text(
                                                    showOwnerdata.isNotEmpty
                                                        ? showOwnerdata[0].name
                                                        : '',
                                                    style: TextStyle(
                                                      color: Color(0xff0F2F4C),
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '? ',
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all<
                                                            Color
                                                          >(Color(0xffBBD3E8)),
                                                      shape: WidgetStateProperty.all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: Text(
                                                      'Cancle',
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xff0F2F4C,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all<
                                                            Color
                                                          >(Colors.red),
                                                      shape: WidgetStateProperty.all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      await deleteCustomerAndRelatedEntries();
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                        Colors.red,
                                      ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
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
                                      controller: _previousDueTEController,
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
                                    icon: Image.asset(
                                      'assets/icons/capture.png',
                                    ),
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
                                onPressed: () {
                                  _submitForm(
                                    showCustomerData.isNotEmpty
                                        ? showOwnerdata[0].name
                                        : '',
                                    showCustomerData.isNotEmpty
                                        ? showOwnerdata[0].phone
                                        : '',
                                    showCustomerData.isNotEmpty
                                        ? showOwnerdata[0].location
                                        : '',
                                    showCustomerData.isNotEmpty
                                        ? showOwnerdata[0].relationType
                                        : '',
                                    showCustomerData.isNotEmpty
                                        ? showOwnerdata[0].photo
                                        : '',
                                  );
                                },
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
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            Text(
                              netAmount >= 0 ? 'Paid:' : 'Due:',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff5B5B5B),
                              ),
                            ),
                            Text(
                              netAmount.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    netAmount >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: Image.asset('assets/icons/taka1.png'),
                            ),
                            SizedBox(width: 220),
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: Image.asset('assets/icons/download.png'),
                                label: const Text('Report'),
                                onPressed: () async {
                                  await generatePdfReport(
        context: context,
        userName: showOwnerdata[0].name ?? '',
        userPhone: showOwnerdata[0].phone ?? '',
        transactions: sortSelectedCustomerData.map((entry) => {
          'date': entry.date,
          'paidAmount': entry.paidAmount,
          'previousDue': entry.previousDue,
          'description': entry.phone,
        }).toList(),
      );
                                },
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: sortSelectedCustomerData.length,
                          itemBuilder: (context, index) {
                            return CustomerSingleTransection(
                              amount:
                                  sortSelectedCustomerData[index].previousDue ==
                                          0
                                      ? sortSelectedCustomerData[index]
                                          .paidAmount
                                          .toString()
                                      : sortSelectedCustomerData[index]
                                          .previousDue
                                          .toString(),
                              date: sortSelectedCustomerData[index].date,
                              paymentType:
                                  sortSelectedCustomerData[index].previousDue ==
                                          0
                                      ? 'Paid'
                                      : 'Due',
                              color:
                                  sortSelectedCustomerData[index].previousDue ==
                                          0
                                      ? Colors.green
                                      : Colors.red,
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
      ),
    );
  }

  Future<void> _submitForm(
    String name,
    String phone,
    String location,
    String type,
    String photo,
  ) async {
    Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'location': location,
      'previous_due':
          double.tryParse(_previousDueTEController.text.trim()) ?? 0.0,
      'paid_amount': double.tryParse(paidAmountTEController.text.trim()) ?? 0.0,
      'photo': photo,
      'type': type,
      'selected_date':
          _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
    };

    try {
      await FirebaseFirestore.instance.collection('entries1').add(data);

      showShackBarMessenger(context, "Entry added successfully", true);
      Navigator.of(context).pop();
    } catch (e) {
      showShackBarMessenger(context, "Failed to add entry: $e", false);
    }
  }

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
    required this.paymentType,
    required this.color,
  });
  final DateTime date;
  final String amount;
  final String paymentType;
  final Color color;
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
              Text(paymentType, style: TextStyle(color: color)),
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
