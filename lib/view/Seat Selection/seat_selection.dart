import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/booking%20history%20page/booking_history_page.dart';
import 'package:restaurant_seat_booking/view/booking%20history%20page/cubit/booking_history_cubit.dart';

import 'cubit/seat_selection_cubit.dart';
import 'cubit/seat_selection_state.dart';

class BookingSeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookingSeatCubit()),
        BlocProvider(create: (context) => BookingHistoryCubit()..loadBookings()),
      ],
      child: _BookingSeatView(),
    );
  }
}

class _BookingSeatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffclr,
      appBar: AppBar(
        iconTheme: IconThemeData(color: iconclr),
        backgroundColor: bgcolor,
        title: Text('Restaurant Seat Booking',
            style: textstyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600)),
      ),
      body: BlocBuilder<BookingSeatCubit, BookingSeatState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date:',
                  style: textstyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: bgcolor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat.yMMMd().format(state.selectedDate), style: textstyle.copyWith(fontWeight: FontWeight.bold)),
                        Icon(Icons.calendar_today, color: iconclr),
                      ],
                    ),
                  ),
                ),
                16.hBox,
                Text(
                  'Select Time:',
                  style: textstyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                8.hBox,
                InkWell(
                  onTap: () => _selectTime(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: bgcolor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.selectedTime.format(context), style: textstyle.copyWith(fontWeight: FontWeight.bold)),
                        Icon(Icons.access_time, color: iconclr),
                      ],
                    ),
                  ),
                ),
                16.hBox,
                Text(
                  'Number of Seats:',
                  style: textstyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                8.hBox,
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: bgcolor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CupertinoPicker(
                    magnification: 1.2,
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(background: Color.fromRGBO(116, 81, 45, 0.411),),
                    itemExtent: 32,
                    onSelectedItemChanged: (int index) {
                      context.read<BookingSeatCubit>().selectNumberOfSeats(index + 1);
                    },
                    children: List<Widget>.generate(10, (index) {
                      return Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: context.read<BookingSeatCubit>().state.numberOfSeats == index + 1 ? Colors.white : bgcolor),
                        ),
                      );
                    }),
                  ),
                ),
                16.hBox,
                Text(
                  'Selected Seats: ${state.numberOfSeats}',
                  style: textstyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                16.hBox,
                Text(
                  'Select Table:',
                  style: textstyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                8.hBox,
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2,
                    ),
                    itemCount: state.tables.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<BookingSeatCubit>().selectTable(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: state.selectedTable == index ? bgcolor : iconclr,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Table ${state.tables[index]}',
                              style: TextStyle(
                                fontSize: 16,
                                color: state.selectedTable == index ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                16.hBox,
                Center(
                  child: InkWell(
                    onTap: () => _bookTable(context, state),
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: bgcolor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Book",
                          style: textstyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: context.read<BookingSeatCubit>().state.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: bgcolor,)), child: child!);
      },
    );
    if (picked != null) {
      context.read<BookingSeatCubit>().selectDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: context.read<BookingSeatCubit>().state.selectedTime,
    );
    if (picked != null) {
      context.read<BookingSeatCubit>().selectTime(picked);
    }
  }

  void _bookTable(BuildContext context, BookingSeatState state) {
    if (state.selectedTable != -1) {
      try {
        // Use the confirmBooking method from BookingSeatCubit
        Map<String, String> newBooking = context.read<BookingSeatCubit>().confirmBooking(context);

        // Add the new booking to the BookingHistoryCubit
        context.read<BookingHistoryCubit>().addBooking(newBooking);

        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            backgroundColor: bgcolor,
            title: Text('Booking Confirmed', style: textstyle),
            content: Text(
              'Table ${state.selectedTable + 1} booked for ${DateFormat.yMd().format(state.selectedDate)} at ${state.selectedTime.format(context)} with ${state.numberOfSeats} seats',
              style: textstyle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<BookingHistoryCubit>(),
                        child: BookingPage(),
                      ),
                    ),
                  );
                },
                child: Text('OK', style: textstyle),
              ),
            ],
          ),
        );
      } catch (e) {
        // Handle the exception (e.g., show an error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      // Show a message if no table is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a table before booking')),
      );
    }
  }
}