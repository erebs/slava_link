import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slava_link/constants/app_images.dart';
import 'package:slava_link/views/pages/home_page.dart';

import 'login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screenNavigation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 250,
            child: Image.asset(AppImages.logo)),
      ),
    );
  }

  screenNavigation () async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = (prefs.getBool('is_logged_in') == null || prefs.getBool('is_logged_in') == false) ? false : true;
    Get.off(()=>isLoggedIn ?  HomePage() : const LoginScreen());

  }

}
