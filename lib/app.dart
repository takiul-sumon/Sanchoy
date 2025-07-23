import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sanchoy/app_routes.dart';
import 'package:sanchoy/app_theme.dart';
import 'package:sanchoy/controller_binder.dart';
import 'package:sanchoy/ui/screans/splash_screan.dart';

class Sanchoy extends StatefulWidget {
  const Sanchoy({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<Sanchoy> createState() => _SanchoyState();
}

class _SanchoyState extends State<Sanchoy> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 917),
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Sanchoy.navigatorKey,
          initialBinding: ControllerBinder(),
          theme: AppTheme.lightThemeData,
          onGenerateRoute: AppRoutes.getRoute,
          initialRoute: SplashScrean.name,
        );
      },
    );
  }
}
