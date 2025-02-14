import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

 //SIGN UP METHOD
  Future signUp({required String email,required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("SUCESS : Sign up successful");
      return "Success";
    } on FirebaseAuthException catch (e) {
      log("EXCEPTION :  ${e.message}");
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email,required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
       log("SUCESS : Sign in successful");
      return "Success";
    } on FirebaseAuthException catch (e) {
      log("EXCEPTION :  ${e.message}");
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    log('signout');
  }
}