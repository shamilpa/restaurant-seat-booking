import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';

class BookingContainer extends StatelessWidget {
  const BookingContainer(
      {super.key,
      required this.Img,
      required this.txt,
      required this.location});
  final String Img;
  final String txt;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              Img,
                            ))),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 22),
                      child: Text(txt,
                          style: textstyle.copyWith(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          10.wBox,
                          Icon(
                              size: 15,
                              Icons.location_on_outlined,
                              color: Color.fromARGB(255, 255, 234, 220)),
                          Text(
                            location,
                            style: textstyle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text("Booked",
                      style: textstyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
