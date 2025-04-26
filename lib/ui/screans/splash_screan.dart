import 'package:flutter/material.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';
import 'package:sanchoy/ui/screans/forgetPasswordVerificationWithEmail.dart';

class splash_Screan extends StatefulWidget {
  const splash_Screan({super.key});

  @override
  State<splash_Screan> createState() => _splash_ScreanState();
}

class _splash_ScreanState extends State<splash_Screan> {
  @override
  void initState() {
    super.initState();
    _movetoNext();
  }

  Future<void> _movetoNext() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Forgetpasswordverificationwithemail(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset(
          'assets/images/splash_screan.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
