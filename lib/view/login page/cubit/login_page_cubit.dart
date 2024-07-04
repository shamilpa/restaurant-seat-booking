import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';

part 'login_page_state.dart';

String? token;

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit(this.context) : super(LoginPageInitial());
  BuildContext context;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

bool _isPasswordVisible = false; 

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(LoginPagePasswordVisibilityChanged(_isPasswordVisible));
  }
  
  

  login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        UserCredential? user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        if (user.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(user.user!.uid.toString());
          token = user.user!.uid;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        }
      }on FirebaseException catch (e) {
        print(e.code);
      }
    }else{
       ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Field is empty")));
    }
  }
}
