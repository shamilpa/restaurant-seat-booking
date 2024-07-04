import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/bottom_nav_bar.dart';
import 'package:restaurant_seat_booking/view%20model/booking_custom.dart';
import 'package:restaurant_seat_booking/unused_bottombar.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key});

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
         backgroundColor: bgcolor,
          title: Text('Cancel Booking',style: textstyle,),
          content: Text('Are you sure you want to cancel this booking?',style: textstyle,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('No',style: textstyle),
            ),
            TextButton(
              onPressed: () {
               
                Navigator.of(context).pop();
              },
              child: Text('Yes',style: textstyle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Booking",
          style: textstyle.copyWith(fontSize: 28,fontWeight: FontWeight.w600),
        ),
        backgroundColor: bgcolor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _showCancelDialog(context),
                  child: BookingContainer(
                    Img: "assets/hoy_punjab.png",
                    txt: "Hoy Punjab",
                    location: "Hilite Mall, Kozhikode",
                  ),
                );
              },
              separatorBuilder: (context, index) => 1.hBox,
              itemCount: 1,
            ),
          ),
        ],
      ),
      backgroundColor: scaffclr,
      // bottomNavigationBar: TestNavBar(),
    );
  }
}
