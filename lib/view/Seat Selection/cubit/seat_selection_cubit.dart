import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'seat_selection_state.dart';

class BookingSeatCubit extends Cubit<BookingSeatState> {
  BookingSeatCubit() : super(BookingSeatState(
    selectedDate: DateTime.now(),
    selectedTime: TimeOfDay.now(),
    tables: List.generate(10, (index) => index + 1),
    numberOfSeats: 1,
    restaurantName: '',
    restaurantImage: '',
  ));

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  void selectTable(int table) {
    emit(state.copyWith(selectedTable: table));
  }

  void selectNumberOfSeats(int seats) {
    emit(state.copyWith(numberOfSeats: seats));
  }

  void setRestaurantDetails(String name, String image) {
    emit(state.copyWith(restaurantName: name, restaurantImage: image));
  }

  Map<String, String> confirmBooking(BuildContext context) {
    if (state.selectedTable != -1) {
      return {
        "Img": state.restaurantImage,
        "txt": "${state.restaurantName} - Table ${state.selectedTable + 1}",
        "location": "${DateFormat.yMd().format(state.selectedDate)} at ${state.selectedTime.format(context)}, ${state.numberOfSeats} seats"
      };
    }
    throw Exception("No table selected");
  }
}