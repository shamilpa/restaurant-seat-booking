import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  BookingHistoryCubit(this.context) : super(BookingHistoryInitial());
  BuildContext context;

  void loadBookings() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookingHistory')
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> bookings = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      emit(BookingsLoaded(bookings));
    } catch (e) {
      print('Error loading bookings: $e');
      emit(BookingHistoryError('Failed to load bookings'));
    }
  }

  void cancelBooking(String bookingId) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookingHistory')
          .doc(bookingId)
          .delete();

      loadBookings();
    } catch (e) {
      print('Error cancelling booking: $e');
      emit(BookingHistoryError('Failed to cancel booking'));
    }
  }
}
