import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_news/global/global_colors.dart';

class CustomBlueButton extends StatelessWidget {
  const CustomBlueButton({
    super.key,
    required this.btnText,
    required this.buttonAction
  });
  final String btnText;
  final VoidCallback buttonAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kSecondaryColor,
      onTap: buttonAction,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 49.h,
            width: 231.w,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
      
            child: Center(child: Text(btnText, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700, fontSize: 16.spMin, color: Colors.white),)),
          )
        ],
      ),
    );
  }
}

