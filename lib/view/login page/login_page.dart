import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view/login%20page/cubit/login_page_cubit.dart';
import 'package:restaurant_seat_booking/view/register%20page/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(175, 143, 111, 1.0),
      backgroundColor: bgcolor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgcolor,
      ),
      body: BlocProvider(
        create: (context) => LoginPageCubit(context),
        child: BlocBuilder<LoginPageCubit, LoginPageState>(
          builder: (context, state) {
            final cubit = context.read<LoginPageCubit>();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/login.png"))),
                    ),
                  ),
                  const Text("Login to continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  20.hBox,
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  5.hBox,
                  Container(
                    width: 350,
                    child: TextFormField(
                      controller: cubit.email,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(175, 143, 111, 1.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide())),
                    ),
                  ),
                  20.hBox,
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.hBox,
                  Container(
                    width: 350,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),

                      obscureText: !cubit.isPasswordVisible,
                      controller: cubit.password,
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                                onTap: cubit.togglePasswordVisibility,
                                child: Icon(
                                  cubit.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 28,
                                  color: Colors.white,
                                )),
                          ),
                          filled: true,
                          fillColor: const  Color.fromRGBO(175, 143, 111, 1.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide())),
                    ),
                  ),
                  20.hBox,
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.hBox,
                  SizedBox(
                    height: 60,
                    width: 120,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            animationDuration: Duration(seconds: 2),
                            backgroundColor: WidgetStatePropertyAll(
                                 Color.fromRGBO(175, 143, 111, 1.0))),
                        onPressed: () {},
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  20.hBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account yet?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      5.wBox,
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color:  Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
