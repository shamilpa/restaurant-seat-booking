import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/cubit/bottom_bar_cubit.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/booking%20history%20page/booking_history_page.dart';
import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';
import 'package:restaurant_seat_booking/view/profile%20page/profile_page.dart';
import 'package:restaurant_seat_booking/view/restaurant%20page/restaurant_page.dart';

class MainPage extends StatelessWidget {
  final int initialIndex;
  const MainPage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return BlocProvider(
      create: (context) => BottomBarCubit()..updateFlag(initialIndex + 2),
      child: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF1F1F1),
            body: _buildBody(context, state.flag),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(bottom: bottomPadding),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(116, 81, 45, 1.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.02,
                    vertical: screenSize.height * 0.01,
                  ),
                  child: GNav(
                    backgroundColor: Colors.transparent,
                    color: iconclr,
                    tabBackgroundColor: Colors.white24,
                    activeColor: Colors.white,
                    selectedIndex: state.flag - 2,
                    onTabChange: (index) {
                      context.read<BottomBarCubit>().updateFlag(index + 2);
                    },
                    gap: screenSize.width * 0.02,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.03,
                      vertical: screenSize.height * 0.01,
                    ),
                    tabs: [
                      _buildGButton(screenSize, Icons.home, 'Home'),
                      _buildGButton(screenSize, Icons.restaurant, 'Restaurant'),
                      _buildGButton(screenSize, Icons.menu_book_outlined, 'Booking'),
                      _buildGButton(screenSize, Icons.person, 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  GButton _buildGButton(Size screenSize, IconData icon, String text) {
    return GButton(
      icon: icon,
      text: text,
      iconSize: screenSize.width * 0.06,
      textStyle: TextStyle(color: Colors.white,
        fontSize: screenSize.width * 0.03,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildBody(BuildContext context, int flag) {
    switch (flag) {
      case 2:
        return BlocProvider.value(
          value: BlocProvider.of<BottomBarCubit>(context),
          child: HomePage(),
        );
      case 3:
        return RestaurantPage();
      case 4:
        return BookingPage();
      case 5:
        return ProfilePage();
      default:
        return 5.hBox;
    }
  }
}