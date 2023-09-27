import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../constants/app_variables.dart';


class AddImageController extends GetxController {
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  upload(String image) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getInt("user_id").toString();
      var request = http.MultipartRequest('POST', Uri.parse(
          '${AppVariables.apiUrl}v2/screenshots'));
      request.fields.addAll({
        'user_id': userId,
      });
      request.files.add(await http.MultipartFile.fromPath('image', image));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        if (kDebugMode) {
          print(res);
        }
        bool status = jsonDecode(res)['status'];
        String msg = jsonDecode(res)['message'];


      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }


}