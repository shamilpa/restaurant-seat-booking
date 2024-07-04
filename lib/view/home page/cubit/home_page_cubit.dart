import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


part 'home_page_state.dart';
String? token;
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.context, this.username, ) : super(HomePageInitial());
  BuildContext context;
    final String username;

homeCubit()async{
  FirebaseFirestore.instance.collection("home").doc(token).collection("user").add({
    "username":username,
  });
}
}
