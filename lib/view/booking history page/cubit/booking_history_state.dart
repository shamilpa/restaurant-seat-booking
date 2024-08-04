part of 'booking_history_cubit.dart';

abstract class BookingHistoryState extends Equatable {
  const BookingHistoryState();

  @override
  List<Object> get props => [];
}

class BookingHistoryInitial extends BookingHistoryState {}

class BookingsLoaded extends BookingHistoryState {
  final List<Map<String, dynamic>> bookings;
  BookingsLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class BookingHistoryError extends BookingHistoryState {
  final String message;
  BookingHistoryError(this.message);

  @override
  List<Object> get props => [message];
}