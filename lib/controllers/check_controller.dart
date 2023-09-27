import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slava_link/controllers/home_controller.dart';
import 'package:slava_link/views/pages/home_page.dart';
import '../constants/app_variables.dart';
import '../models/home_model.dart';
import '../models/status_model.dart';
import '../models/user_model.dart';
import '../utils/snackbar.dart';


class CheckController extends GetxController {
  var isLoading = false.obs;
  late StatusModel statusModel;


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(HomeController homeController, bool isCheckIn) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getInt("user_id").toString();
      String slug = isCheckIn?"check-in":"check-out";
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}v2/$slug')!, body:
      {
        'user_id': userId,
        'v4': "ds",
        'broadcast': "dsd",
        'submask': "dd",
      });
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {

        if (kDebugMode) {
          print(response.body);
        }
        ///data successfully
        statusModel = StatusModel.fromJson(jsonDecode(response.body));

        if(statusModel.statusCode=="01")
          {

              setUserData(isCheckIn);
              homeController.isCheckedOut.value = isCheckIn?false:true;

          }

      } else {
        Snack.show("Something went wrong!");
      }
    } catch (e) {
      Snack.show(e.toString());
      debugPrint(e.toString()+"dd");
    } finally {
      isLoading(false);
    }
  }



  Future<void> setUserData(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_checked_in", status);
  }


}