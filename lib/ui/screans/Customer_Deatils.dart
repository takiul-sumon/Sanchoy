
import 'package:flutter/material.dart';


class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({super.key});

  @override
  CustomerDetailsPageState createState() => CustomerDetailsPageState();
}

class CustomerDetailsPageState extends State<CustomerDetailsPage>
    with SingleTickerProviderStateMixin {



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
                  Image.asset('assets/images/Android Compact - 1.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }





}
