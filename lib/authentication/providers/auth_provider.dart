import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_news/authentication/providers/auth_helper.dart';

class AuthProvider extends ChangeNotifier{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isSingingIn = false;

  changeSignInStatus(){
    isSingingIn  = !isSingingIn;
    notifyListeners();
  }

  AuthenticationHelper authenticationHelper = AuthenticationHelper();


  Future<Map> signInUser() async {
    changeSignInStatus();
    if(_checkEmailField() != ""){
      changeSignInStatus();
      return {"status": "failure", "reason" : _checkEmailField()};
    }
    if(_checkPasswordField() != ""){
      changeSignInStatus();
      return {"status": "failure", "reason" : _checkPasswordField()};
    }
    
    String response = await authenticationHelper.signIn(email: emailController.text.trim(), password: passwordController.text.trim());
    changeSignInStatus();
    if(response == "Success"){
      return {"status" : "success"};
    }
    else{
      return {"status": "failure",  "reason" : "Please check email and password."};
    }
  }

  Future<Map> signUpUser() async {
    changeSignInStatus();
    if(_checkEmailField() != ""){
      changeSignInStatus();
      return {"status": "failure", "reason" : _checkEmailField()};
    }
    if(_checkPasswordField() != ""){
      changeSignInStatus();
      return {"status": "failure", "reason" : _checkPasswordField()};
    }
    if(_checkNameField() != ""){
      changeSignInStatus();
      return {"status": "failure", "reason" : _checkNameField()};
    }
    
    String response = await authenticationHelper.signUp(email: emailController.text.trim(), password: passwordController.text.trim());
    changeSignInStatus();
    if(response == "Success"){
      try {
        FirebaseFirestore.instance 
                .collection('user') 
                .add({'name': nameController.text.trim(), 'email' : emailController.text.trim(),}); 
      
      } catch (e) {
        log("Exception: $e");
      }    
      return {"status" : "success"};
    }
    else{
      return {"status": "failure", "reason" : response};
    }
  }

  signOut(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    authenticationHelper.signOut();
  }

  String _checkNameField(){
    if(nameController.text.isEmpty){
      return "Name can't be empty";
    }
    else if(nameController.text.length < 3){
      return "Invalid name";
    }
    else{
      return "";
    }
  }

  String _checkPasswordField(){
    if(passwordController.text.isEmpty){
      return "Password can't be empty";
    }
    else{
      return "";
    }
  }

  String _checkEmailField(){
    if(emailController.text.isEmpty){
      return "Email can't be empty";
    }
    else if(emailController.text.length < 8){
      return "Invalid email";
    }
    else if(!emailController.text.contains("@")){
      return "Invalid email";
    }
    else if(!emailController.text.contains(".")){
      return "Invalid email";
    }
    else{
      return "";
    }
  }
  
}