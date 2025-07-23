import 'package:flutter/material.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';
import 'package:sanchoy/ui/screans/SignUpScrean.dart';
import 'package:sanchoy/ui/screans/bottom_navigation_bar.dart';
import 'package:sanchoy/ui/screans/forgetPasswordVerificationWithEmail.dart';
import 'package:sanchoy/ui/screans/splash_screan.dart';

class AppRoutes {
  static Route<dynamic> getRoute(RouteSettings settings) {
    late final Widget screenWidget;

    if (settings.name == SplashScrean.name) {
      screenWidget = SplashScrean();
    } else if (settings.name == LoginScreen.name) {
      screenWidget = LoginScreen();
    } else if (settings.name == SignUpScrean.name) {
      screenWidget = SignUpScrean();
    } else if (settings.name == ForgetPasswordWithEmail.name) {
      screenWidget = ForgetPasswordWithEmail();
    } else if (settings.name == BottomNaviationBar.name) {
      screenWidget = BottomNaviationBar();
    }
    return MaterialPageRoute(
      builder: (context) {
        return screenWidget;
      },
    );
  }
}
