import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? "User";
    final profileImage = prefs.getString('profile_image');
    emit(HomePageLoaded(username: username, profileImage: profileImage));
  }

  Future<void> updateUsername(String newUsername) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
    final currentState = state as HomePageLoaded;
    emit(HomePageLoaded(username: newUsername, profileImage: currentState.profileImage));
  }

  Future<void> updateProfilePicture(String base64Image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', base64Image);
    final currentState = state as HomePageLoaded;
    emit(HomePageLoaded(username: currentState.username, profileImage: base64Image));
  }

  Future<void> removeProfilePicture() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image');
    final currentState = state as HomePageLoaded;
    emit(HomePageLoaded(username: currentState.username, profileImage: null));
  }
}