import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constants/app_colors.dart';

class Snack{
   static void show(String message) {

    Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 20),
      messageText:Text(message, style: const TextStyle(fontWeight: FontWeight.bold),),
      borderColor: AppColors.primary,
      borderRadius: 10,
      borderWidth: 2,
      animationDuration: Duration(milliseconds: 400),
      maxWidth:400,
      backgroundColor: AppColors.fontOnSecondary,

    );
  }

}