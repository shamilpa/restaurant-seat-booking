import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/unused_bottombar.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/restaurant_custom.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffclr,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Restaurants",
          style: textstyle.copyWith(fontSize: 28,fontWeight: FontWeight.w600),
        ),
        backgroundColor: bgcolor,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return RestaurantNames(
                      Img: "assets/hoy_punjab.png",
                      txt: "Hoy Punjab",
                      location: "Hilite Mall,Kozhikode",
                    );
                  },
                  separatorBuilder: (context, index) => 1.hBox,
                  itemCount: 8))
        ],
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}