import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_news/global/global_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.inputType,
    this.isPassword = false,
    required this.controller
  });
  final String hintText;
  final TextInputType inputType;
  final bool isPassword;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: inputType,
        style: TextStyle(
            color: kPrimaryColor, fontFamily: "Poppins", fontSize: 14.spMin),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.r),
          ),
          filled: true,
          hintStyle: TextStyle(
              color: Colors.black, fontFamily: "Poppins", fontSize: 14.spMin),
          hintText: hintText,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
