import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/explore_restaurant.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/notification%20page/notification.dart';
import 'package:restaurant_seat_booking/view/profile%20page/profile_page.dart';
import 'package:restaurant_seat_booking/view/restaurant%20page/restaurant_page.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
  final List<String> images = [
    "assets/nahdi logo.png",
    "assets/paragon-restaurant-logo.png",
    "assets/hoy pnb logo.png"
  ];
  // final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffclr,
      appBar: AppBar(
        backgroundColor: bgcolor,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ));
                },
                child: const Icon(
                  Icons.notifications_none,
                  size: 30,
                  color: Color.fromARGB(255, 255, 234, 220),
                )),
          ),
        ],
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://spng.pngfind.com/pngs/s/5-52097_avatar-png-pic-vector-avatar-icon-png-transparent.png"),
                    ))),
          ),
        ),
        title:  Text(
          "Hello, Shamil",
          style: textstyle.copyWith( fontWeight: FontWeight.w600)
        ),
      ),
      drawer: Drawer(
        // ignore: sort_child_properties_last
        child: Stack(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(116, 81, 45, 1.0),
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(116, 81, 45, 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        "https://spng.pngfind.com/pngs/s/5-52097_avatar-png-pic-vector-avatar-icon-png-transparent.png",
                      ),
                    ),
                    10.hBox,
                     Text(
                      "Shamil",
                      style:textstyle.copyWith(fontSize: 20,fontWeight: FontWeight.w600)
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 220, left: 10),
                child: Container(
                  width: 280,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.settings,
                          color: Color.fromARGB(255, 255, 234, 220),
                          size: 30,
                        ),
                      ),
                      Text(
                        "Account Settings",
                        style:textstyle.copyWith(fontSize: 18,fontWeight:FontWeight.bold ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Color.fromARGB(255, 255, 234, 220)
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(175, 143, 111, 1.0),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Center(
            child: Container(
              width: 350,
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 255, 234, 220),
                        )),
                    hintText: "Find restaurants...",
                    hintStyle:  textstyle,
                    contentPadding: const EdgeInsets.all(12)),
              ),
            ),
          ),
        ),
         Padding(
          padding: EdgeInsets.only(left: 25, top: 10),
          child: Row(
            children: [
              Text(
                "Top Dealers",
               style: textstyle.copyWith(fontSize: 25,fontWeight: FontWeight.w800)
               
              ),
            ],
          ),
        ),
        15.hBox,
       
        CarouselSlider(
          items: images.map((image) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurStyle: BlurStyle.normal,
                  )
                ],
                // color: const Color.fromRGBO(116, 81, 45, 1.0),
              ),
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(image: AssetImage(image),fit: BoxFit.contain)
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),

        15.hBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Explore Restaurants",
                style:textstyle.copyWith(fontSize: 20,fontWeight:FontWeight.w600)
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RestaurantPage(),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(116, 81, 45, 1.0),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RestaurantPage(),
                      ));
                    },
                    child: Text("See All",
                        style: textstyle.copyWith(fontSize: 15,fontWeight: FontWeight.w400)),
                  )),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => 5.hBox,
            itemCount: 3,
            itemBuilder: (context, index) {
              return ExploreRestaurant(
                hotelName: "Hotel Paragon Restaurant",
                exploImg: "assets/paragon-restaurant-logo.png",
              );
            },
          ),
        ),
        5.hBox
      ]),
      
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
