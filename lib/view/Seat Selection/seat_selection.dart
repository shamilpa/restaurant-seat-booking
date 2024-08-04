import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/bottom_nav_bar.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'cubit/seat_selection_cubit.dart';
import 'cubit/seat_selection_state.dart';

class BookingSeat extends StatelessWidget {
  final String restaurantName;
  final String restaurantImage;
  const BookingSeat({
    Key? key,
    required this.restaurantName,
    required this.restaurantImage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = BookingSeatCubit();
        cubit.setRestaurantDetails(restaurantName, restaurantImage);
        return cubit;
      },
      child: _BookingSeatView(restaurantImage: restaurantImage,restaurantName: restaurantName,),
    );
  }
}

class _BookingSeatView extends StatelessWidget {
  final String restaurantName;
  final String restaurantImage;
  @override
  const _BookingSeatView({
    Key? key,
    required this.restaurantName,
    required this.restaurantImage,
  }) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffclr,
      appBar: AppBar(
        iconTheme: IconThemeData(color: iconclr),
        backgroundColor: bgcolor,
        title: Text('Restaurant Seat Booking',
            style:
                textstyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600)),
      ),
      body: BlocBuilder<BookingSeatCubit, BookingSeatState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(30)),
                   child: restaurantImage.isNotEmpty
                      ? Image.network(
                          restaurantImage,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          'assets/default_restaurant.png',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                  
                  ),
                  16.hBox,
                  Text(
                    'Select Date:',
                    style: textstyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: bgcolor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat.yMMMd().format(state.selectedDate),
                              style: textstyle.copyWith(
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.calendar_today, color: iconclr),
                        ],
                      ),
                    ),
                  ),
                  16.hBox,
                  Text(
                    'Select Time:',
                    style: textstyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  8.hBox,
                  InkWell(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: bgcolor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state.selectedTime.format(context),
                              style: textstyle.copyWith(
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.access_time, color: iconclr),
                        ],
                      ),
                    ),
                  ),
                  16.hBox,
                  Text(
                    'Number of Seats:',
                    style: textstyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
                      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                        background: Color.fromRGBO(116, 81, 45, 0.411),
                      ),
                      itemExtent: 32,
                      onSelectedItemChanged: (int index) {
                        context
                            .read<BookingSeatCubit>()
                            .selectNumberOfSeats(index + 1);
                      },
                      children: List<Widget>.generate(10, (index) {
                        return Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: context
                                            .read<BookingSeatCubit>()
                                            .state
                                            .numberOfSeats ==
                                        index + 1
                                    ? Colors.white
                                    : bgcolor),
                          ),
                        );
                      }),
                    ),
                  ),
                  16.hBox,
                  Text(
                    'Selected Seats: ${state.numberOfSeats}',
                    style: textstyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  16.hBox,
                  Text(
                    'Select Table:',
                    style: textstyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  8.hBox,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                            color: state.selectedTable == index
                                ? bgcolor
                                : iconclr,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Table ${state.tables[index]}',
                              style: TextStyle(
                                fontSize: 16,
                                color: state.selectedTable == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  16.hBox,
                  Center(
                    child: InkWell(
                      onTap: () async{
                         _bookTable(context, context.read<BookingSeatCubit>().state);
                      },
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
                            style: textstyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
        return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
              primary: bgcolor,
            )),
            child: child!);
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
Future<void> saveBookingToFirestore(String restaurantName, String restaurantImage, String selectedDate, String selectedTime, int numberOfSeats) async {
  try {
    await FirebaseFirestore.instance.collection('bookingHistory').add({
      'restaurantName': restaurantName,
      'restaurantImage': restaurantImage,
      'date': selectedDate,
      'time': selectedTime,
      'guests': numberOfSeats,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': FirebaseAuth.instance.currentUser?.uid,
    });
    print('Booking saved successfully');
  } catch (e) {
    print('Error saving booking: $e');
    rethrow;
  }
}
void _bookTable(BuildContext context, BookingSeatState state) {
  if (state.selectedTable != -1) {
    saveBookingToFirestore(
      restaurantName,
      restaurantImage,
      DateFormat.yMd().format(state.selectedDate),
      state.selectedTime.format(context),
      state.numberOfSeats
    ).then((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: bgcolor,
          title: const Text('Booking Confirmed',
              style: TextStyle(color: Colors.white)),
          content: Text(
            'Table ${state.selectedTable + 1} booked for ${DateFormat.yMd().format(state.selectedDate)} at ${state.selectedTime.format(context)} with ${state.numberOfSeats} seats',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MainPage(initialIndex:2 ,))),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        )
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to save booking: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
}
