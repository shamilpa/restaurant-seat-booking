part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class CurrentName extends ProfileState{
  final String username;
  CurrentName({required this.username});
}

