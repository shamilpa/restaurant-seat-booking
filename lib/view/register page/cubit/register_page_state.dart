part of 'register_page_cubit.dart';

@immutable
sealed class RegisterPageState {}

final class RegisterPageInitial extends RegisterPageState {}
class RegisterPagePasswordVisibilityChanged extends RegisterPageState {
  final bool isPasswordVisible;
   RegisterPagePasswordVisibilityChanged(this.isPasswordVisible); 
}