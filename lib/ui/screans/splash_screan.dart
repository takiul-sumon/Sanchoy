import 'package:flutter/material.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';
import 'package:sanchoy/ui/screans/MainButtomNavScreen.dart';

class Splash_Screan extends StatefulWidget {
  const Splash_Screan({super.key});

  @override
  State<Splash_Screan> createState() => _splash_ScreanState();
}

class _splash_ScreanState extends State<Splash_Screan> {
  @override
  void initState() {
    super.initState();
    _movetoNext();
  }

  Future<void> _movetoNext() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Mainbuttomnavscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('assets/images/splash_screan.png', fit: BoxFit.contain),
    );
  }
}
