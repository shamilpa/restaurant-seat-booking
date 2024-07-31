import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/bottom_nav_bar.dart';
import 'package:restaurant_seat_booking/view/home%20page/cubit/home_page_cubit.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit(this.context) : super(LoginPageInitial());

  final BuildContext context;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPageInitial());
  }

  Future<void> login(BuildContext context) async {
    try {
     
      UserCredential? users = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        if (users.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(users.user!.uid.toString());
          token = users.user!.uid;
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
    } catch (e) {
    print("Login error: $e");
    String errorMessage = e.toString();
    
    if (errorMessage.contains(']')) {
      errorMessage = errorMessage.split('] ').last;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }
}
}