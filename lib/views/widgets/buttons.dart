import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.bgColor = AppColors.primary,
    this.isContinue = false,


  }) : super(key: key);

  String buttonText;
  VoidCallback onTap;
  bool isContinue;
  Color bgColor;


  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      activeOpacity: 0.8,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(18),
        decoration:   BoxDecoration(
            color: bgColor,
            border: Border.all(width: 0, color: bgColor),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Stack(
          children: [

            Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: AppColors.fontOnSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),),
            ),

            Align(
                alignment: Alignment.centerRight,
                child: Icon(Remix.arrow_right_line, color: AppColors.fontOnSecondary, size: isContinue?20:0))

          ],
        ),
      ),
    );
  }
}


class IconNButton extends StatelessWidget {
  IconNButton({
    Key? key,
    required this.buttonText,
    required this.iconData,
    required this.onTap,
    this.bgColor = AppColors.primary,
    this.isContinue = false,


  }) : super(key: key);

  String buttonText;
  VoidCallback onTap;
  bool isContinue;
  Color bgColor;
  IconData iconData;


  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      activeOpacity: 0.8,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration:   BoxDecoration(
            color: bgColor,
            border: Border.all(width: 0, color: bgColor),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.fontOnSecondary,
                    fontWeight: FontWeight.normal,
                    fontSize: 14),),

              SizedBox(width: 5,),

              Icon(iconData, color: AppColors.fontOnSecondary, size: 20)

            ],
          ),
        ),
      ),
    );
  }
}