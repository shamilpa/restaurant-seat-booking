import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view/login%20page/login_page.dart';
import 'package:restaurant_seat_booking/view/register%20page/cubit/register_page_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(12),
          child: AppBar(
            backgroundColor: bgcolor,
          )),
      body: BlocProvider(
        create: (context) => RegisterPageCubit(context),
        child: BlocBuilder<RegisterPageCubit, RegisterPageState>(
          builder: (context, state) {
            final cubit = context.read<RegisterPageCubit>();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/register.png"))),
                      ),
                    ),
                  ),
                  Text("Create an account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  20.hBox,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          "Username",
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
                      controller: cubit.username,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(175, 143, 111, 1.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide())),
                    ),
                  ),
                  20.hBox,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
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
                      style: TextStyle(color: Colors.white),
                      controller: cubit.email,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(175, 143, 111, 1.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide())),
                    ),
                  ),
                  20.hBox,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
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
                          fillColor: Color.fromRGBO(175, 143, 111, 1.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide())),
                    ),
                  ),
                  20.hBox,
                  SizedBox(
                    height: 60,
                    width: 120,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            animationDuration: Duration(seconds: 2),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(175, 143, 111, 1.0))),
                        onPressed: () {
                          cubit.register();
                        },
                        child: Text(
                          "Register",
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
                      Text(
                        "Already have an account?",
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
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
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