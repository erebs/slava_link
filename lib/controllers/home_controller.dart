import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slava_link/views/pages/home_page.dart';
import '../constants/app_variables.dart';
import '../models/home_model.dart';
import '../models/user_model.dart';
import '../utils/snackbar.dart';


class HomeController extends GetxController {
  var isLoading = false.obs;
  late HomeModel homeModel;
  var name = "".obs;
  var designation = "".obs;
  var isCheckedOut = false.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(RxString time, RxString date) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getInt("user_id").toString();
      name.value  = prefs.getString("user_name").toString();
      designation.value = prefs.getString("user_designation").toString();
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}v2/link-home')!, body:
      {
        'user_id': userId,
      });
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {

        if (kDebugMode) {
          print(response.body);
        }
        ///data successfully
        homeModel = HomeModel.fromJson(jsonDecode(response.body));

        if(homeModel.statusCode=="01")
          {
            time.value = homeModel.totalHour!;
            date.value = homeModel.date!;
            setUserData(true);
            isCheckedOut.value = false;
            if(homeModel.status=="Checked Out")
              {
                isCheckedOut.value = true;
                setUserData(false);}
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