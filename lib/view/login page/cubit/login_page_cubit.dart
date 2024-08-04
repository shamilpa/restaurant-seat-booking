import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/bottom_nav_bar.dart';
import 'package:restaurant_seat_booking/view/home%20page/cubit/home_page_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    UserCredential? userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
    if (userCredential.user != null) {
      String uid = userCredential.user!.uid;
      await LocalStorage.setPostData(uid);
      
      final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        final String username = data['username'] ?? "User";
        final String? profileImage = data['profile_image'];
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        if (profileImage != null) {
          await prefs.setString('profile_image', profileImage);
        }
      }
      
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(),));
    }
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