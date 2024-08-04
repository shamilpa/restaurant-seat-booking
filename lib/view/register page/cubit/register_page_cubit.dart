import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';
import 'package:restaurant_seat_booking/view/splash%20screen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_page_state.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit(this.context) : super(RegisterPageInitial());
  BuildContext context;
String? token;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isPasswordVisible = false; 

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(RegisterPagePasswordVisibilityChanged(_isPasswordVisible));
  }

 register() async {
  if (email.text.isNotEmpty && password.text.isNotEmpty && username.text.isNotEmpty) {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        await LocalStorage.setPostData(uid);
        
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "username": username.text,
          "email": email.text,
        });
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username.text);
        await prefs.setString('uid', uid);
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ));
      }
    } on FirebaseException catch (e) {
        print(e.code);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration failed: ${e.message}")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all fields")));
    }
  }
}