import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';

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
          style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),
        ),
      iconTheme: IconThemeData(color: Colors.white),),
      body: Center(
        child: Text("No new notifications",style:TextStyle(color: Colors.white),),
      ),
    );
  }
}
