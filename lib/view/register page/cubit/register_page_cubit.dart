import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';

import '../../login page/cubit/login_page_cubit.dart';

part 'register_page_state.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit(this.context) : super(RegisterPageInitial());
  BuildContext context;

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
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        UserCredential? user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        if (user.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(user.user!.uid);
          token = user!.user!.uid;
          await FirebaseFirestore.instance.collection("user").add({
            "user_name": username.text,
            "email": email.text,
            "user_id": user.user!.uid,
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        }
      } on FirebaseException catch (e) {
        print(e.code);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("something went wrong")));
    }
  }
}
