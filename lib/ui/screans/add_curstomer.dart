import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanchoy/firebase_options.dart'; 
import 'package:sanchoy/ui/widgets/SnackBarMessenger.dart';

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

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  DateTime? _selectedDate;

  FirebaseApp? _secondaryApp;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeSecondaryApp();
  }

  Future<void> _initializeSecondaryApp() async {
    _secondaryApp = await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: DefaultFirebaseOptions.secondaryFirebaseOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  'Add Customer/Supplier',
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
              height: 850 - 100,
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
                    tabs: const [Tab(text: 'Customer'), Tab(text: 'Supplier')],
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
              onPressed: _submitForm,
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

  Future<void> _submitForm() async {
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
      'photo': photoUrl,
      'type': type,
      'selected_date':
          _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
    };

    try {
      await FirebaseFirestore.instance.collection('entries').add(data);

      if (location.toLowerCase() == "dhaka") {
        if (_secondaryApp == null) {
          showShackBarMessenger(
            context,
            "Secondary Firebase not initialized",
            false,
          );
          return;
        }

        await FirebaseFirestore.instanceFor(
          app: _secondaryApp!,
        ).collection('entries').add(data);
      }

      if (location.toLowerCase() == "rajshahi") {
        await FirebaseFirestore.instanceFor(
          app: _secondaryApp!,
        ).collection('entries1').add(data);
      }

      if (location.toLowerCase() == "barishal") {
        await FirebaseFirestore.instanceFor(
          app: _secondaryApp!,
        ).collection('entries2').add(data);
      }
      if (location.toLowerCase() == "rangpur") {
        await FirebaseFirestore.instanceFor(
          app: _secondaryApp!,
        ).collection('entries4').add(data);
      }

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
