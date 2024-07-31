import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view model/booking_custom.dart';
import '../../view model/color_component.dart';
import '../../view model/text_style.dart';
import 'cubit/booking_history_cubit.dart';

class BookingPage extends StatelessWidget {
  BookingPage({Key? key}) : super(key: key);

  void _showCancelDialog(BuildContext context, int index) {
    final bookingHistoryCubit = context.read<BookingHistoryCubit>();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
                Navigator.of(dialogContext).pop();
              },
              child: Text('No', style: textstyle),
            ),
            TextButton(
              onPressed: () {
                bookingHistoryCubit.cancelBooking(index);
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking cancelled successfully')),
                );
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
    return BlocProvider(
      create: (context) => BookingHistoryCubit()..loadBookings(),
      child: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Booking History",
                style: textstyle.copyWith(
                    fontSize: 28, fontWeight: FontWeight.w600),
              ),
              backgroundColor: bgcolor,
            ),
             body: 
             state is BookingsLoaded
              ? Column(
                  children: [
                    Expanded(
                      child: state.bookings.isEmpty
                          ? Center(child: Text("No bookings available", style: textstyle))
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                final booking = state.bookings[index];
                                return GestureDetector(
                                  onTap: () => _showCancelDialog(context, index),
                                  child: BookingContainer(
                                    Img: booking['Img'] ?? '',
                                    txt: booking['txt'] ?? '',
                                    location: booking['location'] ?? '',
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 8),
                              itemCount: state.bookings.length,
                            ),
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
          backgroundColor: scaffclr,
        );
      },
    ));
  }
}
