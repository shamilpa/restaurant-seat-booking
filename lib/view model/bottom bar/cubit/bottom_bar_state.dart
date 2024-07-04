part of 'bottom_bar_cubit.dart';

@immutable
abstract class BottomBarState {
  final int flag;
  const BottomBarState(this.flag);
}

class BottomBarInitial extends BottomBarState {
  const BottomBarInitial(int flag) : super(flag);
}

class BottomBarUpdated extends BottomBarState {
  const BottomBarUpdated(int flag) : super(flag);
}