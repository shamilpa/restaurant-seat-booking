import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.context) : super(ProfileInitial());
  BuildContext context;
  

  void editName(){
    emit(CurrentName(username:"Shamil"));
  }
  void updateName(String username){
    emit(CurrentName(username:username));
  }
}
