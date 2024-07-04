part of 'login_page_cubit.dart';

@immutable
sealed class LoginPageState {}

final class LoginPageInitial extends LoginPageState {}
class LoginPagePasswordVisibilityChanged extends LoginPageState {
  final bool isPasswordVisible;
   LoginPagePasswordVisibilityChanged(this.isPasswordVisible); 
}