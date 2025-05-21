import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({super.key});

  @override
  CustomerDetailsPageState createState() => CustomerDetailsPageState();
}

class CustomerDetailsPageState extends State<CustomerDetailsPage>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  DateTime? _selectedDate;
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
                            child: Image.asset(
                              'assets/images/Ellipse 1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            'আব্দুল্লাহ আল নিশাদ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            '01511223344',
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
                                  '17/2, Block-A, Mirpur-10',
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
                                icon: Image.asset('assets/icons/uiw_date.png'),
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
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CustomerSingleTransection();
                      },
                    ),
                  ),
                  CustomerSingleTransection(),
                  CustomerSingleTransection(),
                  CustomerSingleTransection(),
                  CustomerSingleTransection(),
                  CustomerSingleTransection(),
                  CustomerSingleTransection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onTapGetImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
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
}

class CustomerSingleTransection extends StatelessWidget {
  const CustomerSingleTransection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('05/04/2025', style: TextStyle(color: Color(0xff5B5B5B))),
              SizedBox(width: 16),
              Text('Due', style: TextStyle(color: Color(0xffE80000))),
              SizedBox(width: 32),
              Image.asset('assets/icons/taka.png', color: Color(0xff5B5B5B)),
              SizedBox(width: 5),
              Text('18.00', style: TextStyle(color: Color(0xff5B5B5B))),
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
