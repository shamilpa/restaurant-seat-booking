import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/cubit/bottom_bar_cubit.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view/booking%20page/booking_page.dart';
import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';
import 'package:restaurant_seat_booking/view/profile%20page/profile_page.dart';
import 'package:restaurant_seat_booking/view/restaurant%20page/restaurant_page.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBarCubit(),
      child: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF1F1F1),
            body: _buildBody(state.flag),
            bottomNavigationBar: GNav(
              backgroundColor: const Color.fromRGBO(116, 81, 45, 1.0),
              color: Colors.white,
              tabBackgroundColor: Colors.white24,
              activeColor: Colors.white,
              onTabChange: (index) {
                context.read<BottomBarCubit>().updateFlag(index + 2);
              },
              gap: 4,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.restaurant,
                  text: 'Restaurant',
                ),
                GButton(
                  icon: Icons.menu_book_outlined,
                  text: 'Booking',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(int flag) {
    switch (flag) {
      case 2:
        return HomePage();
      case 3:
        return RestaurantPage();
      case 4:
        return BookingPage();
      case 5:
        return ProfilePage();
      default:
        return  5.hBox; 
    }
  }
}