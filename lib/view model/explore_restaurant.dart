import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/Seat%20Selection/seat_selection.dart';

class ExploreRestaurant extends StatelessWidget {
  ExploreRestaurant({
    Key? key,
    required this.exploImg,
    required this.hotelName,
  }) : super(key: key);

  final String exploImg;
  final String hotelName;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: screenSize.height * 0.13,
          width: screenSize.width * 0.95,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(screenSize.width * 0.025),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: screenSize.width * 0.225,
                  height: screenSize.width * 0.225,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 81, 45, 1.0),
                    borderRadius: BorderRadius.circular(screenSize.width * 0.025),
                    image: DecorationImage(
                      image: NetworkImage(exploImg),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenSize.width * 0.0375,
                    bottom: screenSize.height * 0.05
                  ),
                  child: Text(
                    hotelName,
                    style: textstyle.copyWith(
                      fontSize: screenSize.width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height * 0.0510,
                    left: screenSize.width * 0.055
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => BookingSeat()),
                          );
                        },
                        child: Container(
                          height: screenSize.height * 0.05,
                          width: screenSize.width * 0.155,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(116, 81, 45, 1.0),
                            borderRadius: BorderRadius.circular(screenSize.width * 0.0375),
                          ),
                          child: Center(
                            child: Text(
                              "Book",
                              style: textstyle.copyWith(
                                fontSize: screenSize.width * 0.03,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),SizedBox(height: screenSize.height*0.0055,)
      ],
    );
  }
}