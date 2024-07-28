import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_news/authentication/presentation/login_screen.dart';
import 'package:my_news/authentication/providers/auth_provider.dart';
import 'package:my_news/global/global_colors.dart';
import 'package:my_news/home/presentation/home_screen.dart';
import 'package:my_news/widgets/custom_blue_button.dart';
import 'package:my_news/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: kBackgroundColor,
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 19.h),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MyNews",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: kPrimaryColor,
                      fontSize: 20.spMin,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 149.h,
                ),
                CustomTextField(
                  controller: authProvider.nameController,
                  hintText: "Name",
                  inputType: TextInputType.name,
                ),
                SizedBox(
                  height: 19.h,
                ),
                CustomTextField(
                  controller: authProvider.emailController,
                  hintText: "Email",
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 19.h,
                ),
                CustomTextField(
                  controller: authProvider.passwordController,
                  hintText: "Password",
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                SizedBox(
                  height: 19.h,
                ),
                const Spacer(),
                authProvider.isSingingIn ? const Center(child: CircularProgressIndicator.adaptive(),):  CustomBlueButton(
                  btnText: "Signup",
                  buttonAction: () async {
                    final response = await authProvider.signUpUser();
                    log("Response : $response");
                    if (response["status"] == "success") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const HomeScreen(),
                        ),
                      );
                    } else {
                      var snackBar = SnackBar(
                        content: Text(
                          response["reason"].toString(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
                SizedBox(
                  height: 13.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.spMin,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.spMin,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
