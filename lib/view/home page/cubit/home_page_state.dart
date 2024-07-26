part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final String username;
  final String? profileImage;

  HomePageLoaded({required this.username, this.profileImage});
}