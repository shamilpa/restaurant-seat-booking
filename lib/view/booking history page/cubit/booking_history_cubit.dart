import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  BookingHistoryCubit() : super(BookingHistoryInitial());
  

  void loadBookings(){
    final bookings=[
      {
       "Img": "assets/hoy_punjab.png", "txt": "Hoy Punjab", "location": "Hilite Mall, Kozhikode"
      }
    ];
    emit(BookingsLoaded(bookings));
  }
  void cancelBooking(int index){
    if(state is BookingsLoaded){
      final currentstate=state as BookingsLoaded;
      final updatedbooking=List<Map<String, String>>.from(currentstate.bookings);
      updatedbooking.removeAt(index);
      emit(BookingsLoaded(updatedbooking));
    }
  }
}
