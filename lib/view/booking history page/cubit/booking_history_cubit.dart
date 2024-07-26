// booking_history_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  BookingHistoryCubit() : super(BookingHistoryInitial());
  
  void loadBookings() {
    final bookings = [
     
    ];
    emit(BookingsLoaded([]));
  }

  void addBooking(Map<String, String> booking) {
    if (state is BookingsLoaded) {
      final currentState = state as BookingsLoaded;
      final updatedBookings = List<Map<String, String>>.from(currentState.bookings)
        ..add(booking);
      emit(BookingsLoaded(updatedBookings));
      print('Booking added. Total bookings: ${updatedBookings.length}');
    } else {
      loadBookings();
      addBooking(booking);
    }
  }

  void cancelBooking(int index) {
    if (state is BookingsLoaded) {
      final currentState = state as BookingsLoaded;
      final updatedBookings = List<Map<String, String>>.from(currentState.bookings);
      updatedBookings.removeAt(index);
      emit(BookingsLoaded(updatedBookings));
      print('Booking cancelled. Remaining bookings: ${updatedBookings.length}');
    } else {
      print('Cannot cancel booking: State is not BookingsLoaded');
    }
  }
}