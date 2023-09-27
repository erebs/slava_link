import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slava_link/controllers/check_controller.dart';
import 'package:slava_link/controllers/home_controller.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../controllers/upload_image_controller.dart';
import '../widgets/buttons.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AddImageController addImageController = Get.put(AddImageController());
  CheckController checkController = Get.put(CheckController());
  HomeController homeController = Get.put(HomeController());
  RxString image = RxString("");
  Timer? timer, homeFetch;
  RxString time = RxString("00:000:00");
  RxString date = RxString("YYYY-MM-DD");

  @override
  void initState() {
    homeController.fetchData(time,date);
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 60), (Timer t) => screenNavigation());
    homeFetch = Timer.periodic(const Duration(seconds: 10), (Timer t) => homeController.fetchData(time,date));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Obx(() => homeController.isLoading.value?Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: homeController.name+"\n",
                          style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary, fontSize: 15),
                        ),
                        TextSpan(
                          text: homeController.designation+"\n",
                          style: TextStyle(fontWeight: FontWeight.normal,color: AppColors.primary, fontSize: 12),
                        ),
                        TextSpan(
                          text: homeController.isCheckedOut.value?"Your have stopped working":"Your are working now",
                          style: TextStyle(fontWeight: FontWeight.bold,color: homeController.isCheckedOut.value?Colors.redAccent:Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                  ):Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: homeController.name+"\n",
                          style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary, fontSize: 15),
                        ),
                        TextSpan(
                          text: homeController.designation+"\n",
                          style: TextStyle(fontWeight: FontWeight.normal,color: AppColors.primary, fontSize: 12),
                        ),
                        TextSpan(
                          text: homeController.isCheckedOut.value?"Your have stopped working":"Your are working now",
                          style: TextStyle(fontWeight: FontWeight.bold,color: homeController.isCheckedOut.value?Colors.redAccent:Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                  )),

                  Row(
                    children: [
                      IconNButton(
                        buttonText: 'Refresh', iconData: Remix.refresh_fill,
                        onTap: () { homeController.fetchData(time,date); },),

                      SizedBox(width: 15,),

                      IconNButton(
                        buttonText: 'Logout', iconData: Remix.logout_circle_fill,
                        onTap: () { logout(); },),
                    ],
                  )

                ],
              ),
            ),
          ),

          Column(
            children: [
              Obx(() => homeController.isCheckedOut.value?TouchableOpacity(
                onTap: (){
                  checkController.fetchData(homeController, true);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration:   BoxDecoration(
                      color: Colors.green,
                      border: Border.all(width: 4, color: Colors.black),
                      borderRadius: BorderRadius.circular(200)
                  ), width: 150, height: 150, child: Text(checkController.isLoading.value?"Please wait..":  "Check In",
                  style: TextStyle(fontWeight: FontWeight.bold),),),
              ):TouchableOpacity(
                onTap: (){
                  checkController.fetchData(homeController, false);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration:   BoxDecoration(
                      color: Colors.redAccent,
                      border: Border.all(width: 4, color: Colors.black),
                      borderRadius: BorderRadius.circular(200)
                  ), width: 150, height: 150, child: Text(checkController.isLoading.value?"Please wait..":"Check Out",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),),
              )),

              SizedBox(height: 20,),

              Obx(() => homeController.isLoading.value?Text(time.value,
                style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,):Text(time.value,
                style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold,
                    color: homeController.isCheckedOut.value?Colors.redAccent:Colors.green),
                textAlign: TextAlign.center,)),

              Obx(() => homeController.isLoading.value?Text(date.value,
                style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,):Text(date.value,
                style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,)),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 40,
                      child: Image.asset(AppImages.logo)),
                  SizedBox(height: 10,),
                  Text("Copyright © 2023. All Rights Reserved\nERE Business Solutions Pvt. Ltd.",
                  style: TextStyle(height: 1.2, fontSize: 14),
                  textAlign: TextAlign.right,),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  screenNavigation () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCheckedIn = (prefs.getBool('is_checked_in') == null || prefs.getBool('is_checked_in') == false) ? false : true;
    if(isCheckedIn)
      {
        Directory directory = await getApplicationDocumentsDirectory();
        String imagePath = '${directory.path}/Slava Link/Screenshots.jpg';
        CapturedData? capturedData = await screenCapturer.capture(
          mode: CaptureMode.screen,
          imagePath: imagePath,
          copyToClipboard: false,
        );
        addImageController.upload(capturedData!.imagePath!);
      }

  }

  logout() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", 0);
    await prefs.setString("user_name", "");
    await prefs.setString("user_mobile", "");
    await prefs.setString("user_designation", "");
    await prefs.setString("user_email", "");
    await prefs.setString("user_eid", "");
    await prefs.setBool("is_logged_in", false);
    Get.offAll(const LoginScreen());
  }

}


