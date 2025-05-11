import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sanchoy/ui/controller/controller_binder.dart';
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
    return GetMaterialApp(
      navigatorKey: Sanchoy.navigatorKey,
      initialBinding: ControllerBinder(),

      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, strokeAlign: 5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      home: Splash_Screan(),
    );
  }
}
