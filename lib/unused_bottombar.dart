// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:restaurant_seat_booking/view/booking%20page/booking_page.dart';
// import 'package:restaurant_seat_booking/view/home%20page/home_page.dart';
// import 'package:restaurant_seat_booking/view/profile%20page/profile_page.dart';
// import 'package:restaurant_seat_booking/view/restaurant%20page/restaurant_page.dart';

// class BottomNavBar extends StatelessWidget {
//    BottomNavBar({super.key,this.index});
//    num?index;
// List screens=[
//   HomePage(),
//   RestaurantPage(),
//   BookingPage(),
//   ProfilePage()
// ];
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         canvasColor: Color.fromRGBO(116, 81, 45, 1.0),

//       ),
//       child: BottomNavigationBar(
        
//         backgroundColor: Color.fromARGB(255, 253, 219, 231),
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.restaurant),
//             label: 'Restaurants',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.summarize),
//             label: 'Summary',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile')
//         ],
//         currentIndex: index!.toInt(),
//         selectedItemColor:const Color.fromRGBO(175, 143, 111, 1.0),

//         unselectedItemColor: Colors.white,
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => HomePage(),
//               ));
//               break;
//               case 1:
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => RestaurantPage(),));
//               break;
//               case 2:
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingPage(),));
//               break;
//               case 3:
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(),));

//           }
//         },
//       ),
//     );
//   }
// }





// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

// import '../../view/home page/home_page.dart';
// import '../../view/profile page/profile_page.dart';
// import '../../view/restaurant page/restaurant_page.dart';
// import '../../view/booking page/booking_page.dart';

// class BottomNavBar extends StatelessWidget {
//   BottomNavBar({super.key,this.index});
//   num?index;
//   final List<Widget> screens = [
//     HomePage(), RestaurantPage(), BookingPage(), ProfilePage()];
//   @override
//   Widget build(BuildContext context) {
//     return GNav(
//               backgroundColor: const Color.fromRGBO(116, 81, 45,1.0),

//       color: Colors.white,
//       tabBackgroundColor: Colors.white24,
//       activeColor: Colors.white,
//       onTabChange: (index) {
        
//         print("Index is $index");
//       },
//       gap: 4,
//       tabs: [
//         const GButton(
          
//           icon: Icons.home,
//           text: 'Home',
//         ),
//         const GButton(
//           icon: Icons.restaurant,
//           text: 'Restaurant',
//         ),
//         const GButton(
//           icon: Icons.menu_book_outlined,
//           text: 'Booking',
//         ),
//         const GButton(
//           icon: Icons.person,
//           text: 'Profile',
//         )
//       ],
//     );
//   }
// }





