import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_seat_booking/view%20model/booking_custom.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/booking%20history%20page/cubit/booking_history_cubit.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key});

  void _showCancelDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgcolor,
          title: Text(
            'Cancel Booking',
            style: textstyle,
          ),
          content: Text(
            'Are you sure you want to cancel this booking?',
            style: textstyle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No', style: textstyle),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Yes', style: textstyle),
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
          "Booking History",
          style: textstyle.copyWith(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        backgroundColor: bgcolor,
      ),
      body: BlocProvider(
        create: (context) => BookingHistoryCubit(),
        child: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
          builder: (context, state) {
            if (state is BookingHistoryInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BookingsLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showCancelDialog(context, index),
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
              );
            } else {
              return Center(child: Text("something went wrong"));
            }
          },
        ),
      ),
      backgroundColor: scaffclr,
      // bottomNavigationBar: TestNavBar(),
    );
  }
}
