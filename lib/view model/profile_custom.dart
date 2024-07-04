import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';

class ProfileDetails extends StatelessWidget {
  ProfileDetails({super.key, required this.txt, required this.icon, this.onTAp,});
  final String txt;
  IconData? icon;
  final VoidCallback? onTAp;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: onTAp,
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.black38, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      icon,
                      color: Color.fromARGB(255, 255, 234, 220),
                      size: 30,
                    ),
                  ),
                  10.wBox,
                  Text(
                    txt,
                    style:  textstyle.copyWith(fontSize: 18,fontWeight: FontWeight.bold)
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Icon(Icons.keyboard_arrow_right_sharp,color: Color.fromARGB(255, 255, 234, 220),),
                    
                  ),
                  
                ],
                
              ),
            ),
          ),
        ),
      ],
    );
  }
}
