import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffclr,

      appBar: AppBar(
        
        backgroundColor: bgcolor,

        title: Text(
          "Notifications",
          style: textstyle.copyWith(fontWeight: FontWeight.w800),
        ),
      iconTheme: IconThemeData(color: Colors.white),),
      body: Center(
        child: Text("No new notifications",style:textstyle,),
      ),
    );
  }
}
