import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:restaurant_seat_booking/view%20model/bottom%20bar/bottom_nav_bar.dart';
import 'dart:convert';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/explore_restaurant.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/home%20page/cubit/home_page_cubit.dart';
import 'package:restaurant_seat_booking/view/notification%20page/notification.dart';
import 'package:restaurant_seat_booking/view/profile%20page/profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> images = [
    "assets/nahdi logo.png",
    "assets/paragon-restaurant-logo.png",
    "assets/hoy pnb logo.png"
  ];
  Future<String> getDownloadURL(String gsUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error getting download URL: $e");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CollectionReference<Map<String, dynamic>> restaurant =
        FirebaseFirestore.instance.collection('restaurants');

    return BlocProvider(
      create: (context) => HomePageCubit()..loadUserData(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLoaded) {
            return Scaffold(
              backgroundColor: scaffclr,
              appBar: AppBar(
                backgroundColor: bgcolor,
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.notifications_none,
                        size: size.width * 0.08,
                        color: Color.fromARGB(255, 255, 234, 220),
                      ),
                    ),
                  ),
                ],
                leading: Builder(
                  builder: (context) => Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: CircleAvatar(
                          radius: size.width * 0.04,
                          backgroundImage: state.profileImage != null
                              ? MemoryImage(base64Decode(state.profileImage!))
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  "Hello, ${state.username}",
                  style: textstyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              drawer: Drawer(
                backgroundColor: const Color.fromRGBO(175, 143, 111, 1.0),
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
                            CircleAvatar(
                                radius: size.width * 0.1,
                                backgroundImage: state.profileImage != null
                                    ? MemoryImage(
                                        base64Decode(state.profileImage!))
                                    : null),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              state.username,
                              style: textstyle.copyWith(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.27,
                      left: size.width * 0.02,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ));
                        },
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.settings,
                                color: Color.fromARGB(255, 255, 234, 220),
                                size: size.width * 0.08,
                              ),
                              Text(
                                "Account Settings",
                                style: textstyle.copyWith(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_sharp,
                                color: Color.fromARGB(255, 255, 234, 220),
                                size: size.width * 0.08,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: StreamBuilder(
                  stream: restaurant.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Center(
                              child: Container(
                                width: size.width * 0.9,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  style: textstyle,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.search,
                                        color: iconclr,
                                        size: size.width * 0.06,
                                      ),
                                    ),
                                    hintText: "Find restaurants...",
                                    hintStyle: textstyle,
                                    contentPadding:
                                        EdgeInsets.all(size.width * 0.04),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.06,
                                top: size.height * 0.01),
                            child: Row(
                              children: [
                                Text(
                                  "Top Dealers",
                                  style: textstyle.copyWith(
                                      fontSize: size.width * 0.06,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          CarouselSlider(
                            items: images.map((image) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 5,
                                    color: Colors.black45,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurStyle: BlurStyle.normal,
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.all(size.width * 0.01),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(image),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: size.height * 0.25,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(size.width * 0.02),
                                child: Text(
                                  "Explore Restaurants",
                                  style: textstyle.copyWith(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainPage(initialIndex: 1)),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.02,
                                      right: size.width * 0.025,
                                      bottom: size.height * 0.01),
                                  child: Container(
                                    height: size.height * 0.05,
                                    width: size.width * 0.155,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          116, 81, 45, 1.0),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "See All",
                                        style: textstyle.copyWith(
                                            fontSize: size.width * 0.03,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: size.height * 0.01),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot restaurantSnap =
                                      snapshot.data!.docs[index];
                                  final String gsUrl =
                                      restaurantSnap['image'] ?? '';
                                  return FutureBuilder<String>(
                                    future: getDownloadURL(gsUrl),
                                    builder: (context, urlSnapshot) {
                                      if (urlSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      final String imageUrl =
                                          urlSnapshot.data ?? '';
                                      print(
                                          "Restaurant ${index + 1} image URL: $imageUrl");
                                      return ExploreRestaurant(
                                        hotelName: restaurantSnap['name'],
                                        exploImg: imageUrl,
                                      );
                                    },
                                  );
                                }),
                          )
                        ],
                      );
                    }
                  }),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
