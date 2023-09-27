import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slava_link/constants/app_images.dart';
import 'package:slava_link/controllers/login_controller.dart';
import 'package:slava_link/views/widgets/buttons.dart';
import 'package:slava_link/views/widgets/inputs.dart';

import '../../constants/app_colors.dart';
import '../../utils/snackbar.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isPassword = true;
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Stack(
        children: [


          Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration:   BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(25)
              ),
              width: 400,
              height: 420,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child: SizedBox(
                      height: 50,
                        child: Image.asset(AppImages.logo)),
                  ),
                  SizedBox(height: 30,),

                  const Text("Mobile number", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                  EditableBox(
                      controller: mobileController,
                      hint: "Enter your mobile number",
                      type: TextInputType.phone),

                  SizedBox(height: 15,),
                  const Text("Password", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                  EditableBoxPass(
                      controller: passwordController,
                      isPassword: isPassword,
                      hint: "Enter your password",
                      onPressed: () {
                        setState(() {isPassword = !isPassword;},);
                      },
                      type: TextInputType.visiblePassword),

                  const SizedBox(height: 30,),
                  PrimaryButton(
                      buttonText: "Login",
                      onTap: () {
                        if(mobileController.text.length == 10 && passwordController.text.isNotEmpty)
                          {
                            loginController.fetchData(mobileController.text, passwordController.text);
                          }else
                            {
                              Snack.show("Some required fields are empty!");
                            }
                      })


                ],
              ),
            ),
          ),

          Obx(() => loginController.isLoading.value?Container(
            color: Colors.white.withOpacity(0.6),
            child: const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black,),
              ),
            ),
          ):const SizedBox())

        ],
      ),
    );
  }
}
