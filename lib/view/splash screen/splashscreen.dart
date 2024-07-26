import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view/login%20page/login_page.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  Future<void> fetchToken() async {
    token = await LocalStorage.getData();
    bool isTokenValid = await validateToken(token);
    print("Token: $token, Is Valid: $isTokenValid");
    if (mounted) {
      setState(() {
        token = isTokenValid ? token : null;
      });
    }
  }

  Future<bool> validateToken(String? token) async {
    if (token == null) return false;
    // TODO: Implement your token validation logic here.
    // This could involve decoding a JWT token to check its expiration,
    // or making a lightweight API call to verify the token is still valid.
    return true; // For now, assume all non-null tokens are valid
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.network("https://lottie.host/f6a6a7b8-f806-4829-ad13-1994a83ddb5b/QgV9Xsiucm.json"),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(116, 81, 45, 1.0),
      nextScreen: token == null ? LoginPage() : MainPage(),
      splashIconSize: 400,
      duration: 2000,
    );
  }
}