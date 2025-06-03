import 'package:flutter/material.dart';
import 'package:sanchoy/ui/screans/MainButtomNavScreen.dart';

class SplashScrean extends StatefulWidget {
  const SplashScrean({super.key});

  @override
  State<SplashScrean> createState() => _SplashScreanState();
}

class _SplashScreanState extends State<SplashScrean> {
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
