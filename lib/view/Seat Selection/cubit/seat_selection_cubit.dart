import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'seat_selection_state.dart';

class BookingSeatCubit extends Cubit<BookingSeatState> {
  BookingSeatCubit() : super(BookingSeatState(
    selectedDate: DateTime.now(),
    selectedTime: TimeOfDay.now(),
    tables: List.generate(10, (index) => index + 1),
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
}