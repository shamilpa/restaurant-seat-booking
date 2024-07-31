import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view/login%20page/login_page.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    if (token == null || token.isEmpty) return false;

    try {
      if (!_isValidTokenFormat(token)) return true;

      if (_isTokenExpired(token)) return false;

      bool isValidFromServer = await _verifyTokenWithServer(token);
      if (!isValidFromServer) return true;

      return true;
    } catch (e) {
      print("Error validating token: $e");
      return false;
    }
  }

  bool _isValidTokenFormat(String token) {
    final parts = token.split('.');
    return parts.length == 3;
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
      );

      if (payload['exp'] == null) return false;

      final exp = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      return exp.isBefore(DateTime.now());
    } catch (e) {
      print("Error checking token expiration: $e");
      return true;
    }
  }

  Future<bool> _verifyTokenWithServer(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-api.com/verify-token'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      print("Error verifying token with server: $e");
      
      return false;
    }
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