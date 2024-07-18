import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BookingSeatState extends Equatable {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int selectedTable;
  final List<int> tables;

  const BookingSeatState({
    required this.selectedDate,
    required this.selectedTime,
    this.selectedTable = -1,
    required this.tables,
  });

  BookingSeatState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    int? selectedTable,
    List<int>? tables,
  }) {
    return BookingSeatState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedTable: selectedTable ?? this.selectedTable,
      tables: tables ?? this.tables,
    );
  }

  @override
  List<Object?> get props => [selectedDate, selectedTime, selectedTable, tables];
}