import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view model/color_component.dart';
import '../../view model/text_style.dart';
import 'cubit/booking_history_cubit.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  void _showCancelDialog(BuildContext context, String bookingId) {
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
                bookingHistoryCubit.cancelBooking(bookingId);
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
      create: (context) => BookingHistoryCubit(context)..loadBookings(),
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
            body: state is BookingsLoaded
                ? Column(
                    children: [
                      Expanded(
                        child: state.bookings.isEmpty
                            ? Center(child: Text("No bookings available", style: textstyle))
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  final booking = state.bookings[index];
                                  return GestureDetector(
                                    onTap: () => _showCancelDialog(context, booking['id']),
                                    child: Card(
                                      margin: EdgeInsets.all(8),
                                      child: ListTile(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: bgcolor)) ,
                                        tileColor: bgcolor,
                                        leading: Image.network(
                                          booking['restaurantImage'],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(booking['restaurantName'], style: textstyle),
                                        subtitle: Text(
                                          'Date: ${booking['date']}    Time: ${booking['time']}',
                                          style: textstyle,
                                        ),
                                        trailing: Text('Seats: ${booking['guests']}', style: textstyle),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: state.bookings.length,
                              ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
            backgroundColor: scaffclr,
          );
        },
      ),
    );
  }
}