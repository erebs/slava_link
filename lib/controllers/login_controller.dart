import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slava_link/views/pages/home_page.dart';
import '../constants/app_variables.dart';
import '../models/user_model.dart';
import '../utils/snackbar.dart';


class LoginController extends GetxController {
  var isLoading = false.obs;
  late UserModel userModel;
  late User user;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String mobileNumber,String password) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}v2/login')!, body:
      {
        'mobile_number': mobileNumber,
        'password': password,
      });
      if (response.statusCode == 200) {

        if (kDebugMode) {
          print(response.body);
        }
        ///data successfully
        userModel = UserModel.fromJson(jsonDecode(response.body));

        if(userModel.statusCode=="01")
          {
            user =  userModel.user!;
            setUserData();
          }else {
          Snack.show(userModel.message!);
        }

      } else {
        Snack.show("Something went wrong!");
      }
    } catch (e) {
      Snack.show(e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }



  Future<void> setUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", user.id!);
    await prefs.setString("user_name", user.name!);
    await prefs.setString("user_mobile", user.mobile!);
    await prefs.setString("user_designation", user.designation!);
    await prefs.setString("user_email", user.email!);
    await prefs.setString("user_eid", user.employeeId!);
    await prefs.setBool("is_logged_in", true);

    Get.off( HomePage());
  }


}