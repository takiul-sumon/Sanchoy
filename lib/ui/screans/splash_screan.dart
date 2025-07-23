import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanchoy/assets_paths.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';

class SplashScrean extends StatefulWidget {
  const SplashScrean({super.key});
  static final String name = 'splash-screen';

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
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushNamed(context, LoginScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AssetsPaths.splash_screen,
        fit: BoxFit.cover,
        height: 917.h,
        width: 412.w,
      ),
    );
  }
}
