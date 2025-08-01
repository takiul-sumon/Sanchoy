import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanchoy/ui/commons/SnackBarMessenger.dart';

class AddCustomerSupplierPage extends StatefulWidget {
  const AddCustomerSupplierPage({super.key});

  @override
  AddCustomerSupplierPageState createState() => AddCustomerSupplierPageState();
}

class AddCustomerSupplierPageState extends State<AddCustomerSupplierPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _locationTEController = TextEditingController();
  final TextEditingController _previousDueTEController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff2370B4)),
                ),
                Positioned(
                  top: 44.h,
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
                        'Add Customer/Supplier',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 108.h,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 809.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffE9F1F8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          indicatorColor: Colors.blue,
                          tabs: const [
                            Tab(text: 'Customer'),
                            Tab(text: 'Supplier'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [_buildForm(), _buildForm()],
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
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xffE9F1F8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.contacts),
              label: const Text('Choose from Contacts'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black87,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Image.asset('assets/icons/User.png'),
                hintText: 'Name',
              ),
              controller: _nameTEController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              validator: (String? value) {
                String name = value!;
                if (name.isEmpty) {
                  return "Enter A name";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Image.asset('assets/icons/User.png'),
                hintText: 'Phone',
              ),
              controller: _phoneTEController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }

                final pattern = r'^(?:\+?88)?01[3-9]\d{8}$';
                final regExp = RegExp(pattern);

                if (!regExp.hasMatch(value)) {
                  return 'Enter a valid BD phone number';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Image.asset('assets/icons/User.png'),
                hintText: 'Location',
              ),
              controller: _locationTEController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.money),
                hintText: 'Previous Due',
              ),
              controller: _previousDueTEController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Enter a amount";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _selectedDate == null
                          ? 'Pick Date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Photo'),
                    onPressed: onTapGetImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onTapValidate,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
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

  Future<void> onTapGetImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  onTapValidate() {
    if (_key.currentState!.validate()) {
      _submitForm();
    }
  }

  Future<void> _submitForm() async {
    String uid = user!.uid;

    if (_nameTEController.text.isEmpty || _phoneTEController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and Phone are required")),
      );
      return;
    }

    String? photoUrl;
    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      photoUrl = encodedImage;
    }

    String type = _tabController.index == 0 ? 'Customer' : 'Supplier';
    String location = _locationTEController.text.trim();

    Map<String, dynamic> data = {
      'name': _nameTEController.text.trim(),
      'phone': _phoneTEController.text.trim(),
      'location': location,
      'previous_due':
          double.tryParse(_previousDueTEController.text.trim()) ?? 0.0,
      'paid_amount': 0.0,

      'photo': photoUrl,
      'type': type,
      'selected_date':
          _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
    };

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('entries1')
          .add(data);

      showShackBarMessenger(context, "Entry added successfully", true);
      Navigator.of(context).pop();
    } catch (e) {
      showShackBarMessenger(context, "Failed to add entry: $e", false);
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();

    _phoneTEController.dispose();
    _locationTEController.dispose();
    _previousDueTEController.dispose();
    super.dispose();
  }
}
