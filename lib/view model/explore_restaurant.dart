import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/booking%20page/seat_selection.dart';

class ExploreRestaurant extends StatelessWidget {
  ExploreRestaurant(
      {super.key, required this.exploImg, required this.hotelName});
  final String exploImg;
  final String hotelName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 400,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 81, 45, 1.0),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(exploImg), fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 50),
                  child: Text(
                    hotelName,
                    style: textstyle.copyWith(fontSize: 15,fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingSeat(),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 10),
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                         color: const Color.fromRGBO(116, 81, 45, 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text("Book",
                              style:textstyle.copyWith(fontSize: 16,fontWeight: FontWeight.w400))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
