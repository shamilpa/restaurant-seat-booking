import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BookingSeatState extends Equatable {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int selectedTable;
  final List<int> tables;
  final int numberOfSeats;
  final String restaurantName;
  final String restaurantImage;
  final String restaurantLocation;

  const BookingSeatState({
    required this.selectedDate,
    required this.selectedTime,
    this.selectedTable = -1,
    required this.tables,
    this.numberOfSeats = 1,
    required this.restaurantName,
    required this.restaurantImage,
    this.restaurantLocation = '',
  });

  BookingSeatState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    int? selectedTable,
    List<int>? tables,
    int? numberOfSeats,
    String? restaurantName,
    String? restaurantImage,  String? restaurantLocation,
  }) {
    return BookingSeatState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedTable: selectedTable ?? this.selectedTable,
      tables: tables ?? this.tables,
      numberOfSeats: numberOfSeats ?? this.numberOfSeats,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      restaurantLocation: restaurantLocation ?? this.restaurantLocation, 
    );
  }

  @override
  List<Object?> get props => [selectedDate, selectedTime, selectedTable, tables, numberOfSeats, restaurantName, restaurantImage,restaurantLocation];
}