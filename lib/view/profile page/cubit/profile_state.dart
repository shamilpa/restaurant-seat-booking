part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String username;
  final String? profileImage;

  ProfileLoaded({required this.username, this.profileImage});
}