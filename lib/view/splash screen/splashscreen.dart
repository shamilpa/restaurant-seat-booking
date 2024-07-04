import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';
import 'package:restaurant_seat_booking/view/login%20page/login_page.dart';


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
    print("Token: $token");
    if (mounted) {
      setState(() {});
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
      
      
      nextScreen: token == null ? LoginPage() : HomePage(),
      splashIconSize: 400,
      duration: 2000, 
    );
  }
}



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:restaurant_seat_booking/local_storage.dart';
// import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';
// import 'package:restaurant_seat_booking/view/login%20page/cubit/login_page_cubit.dart';
// import 'package:restaurant_seat_booking/view/login%20page/login_page.dart';


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   splashData() async {
//      token =await LocalStorage.getData();
//      print("????????????////////$token");
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => token == null ? LoginPage() : HomePage(),
//     ));
//   }
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Timer(Duration(seconds: 2),splashData);

//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Center(child: Text("WELCOME",),),
//     );
//   }
// }
