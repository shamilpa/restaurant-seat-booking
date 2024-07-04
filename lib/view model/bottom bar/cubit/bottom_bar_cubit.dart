import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarInitial(2));

  void updateFlag(int newFlag) {
    emit(BottomBarUpdated(newFlag));
  }
}