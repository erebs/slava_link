import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:slava_link/views/pages/home_page.dart';
import 'package:slava_link/views/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff0f9600),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.grey.withOpacity(0.3),
      ),
      home: const SplashScreen(),
    );
  }
}