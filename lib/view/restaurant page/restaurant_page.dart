import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view/Seat%20Selection/seat_selection.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

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
    final CollectionReference restaurant =
        FirebaseFirestore.instance.collection('restaurants');
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text(
          "Restaurants",
          style: textstyle.copyWith(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        backgroundColor: bgcolor,
      ),
      backgroundColor: scaffclr,
      body: StreamBuilder(
          stream: restaurant.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
           
            } else {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Center(
                      child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
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
                            hintText: "Search restaurants...",
                            hintStyle: textstyle,
                            contentPadding: EdgeInsets.all(size.width * 0.04),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot restaurantSnap = snapshot.data!.docs[index];
                        final String gsUrl = restaurantSnap['image'] ?? '';

                        return FutureBuilder<String>(
                          future: getDownloadURL(gsUrl),
                          builder: (context, urlSnapshot) {
                            if (urlSnapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            final String imageUrl = urlSnapshot.data ?? '';
                            print("Restaurant ${index + 1} image URL: $imageUrl");

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.045,
                                vertical: size.height * 0.01,
                              ),
                              child: Card(
                                color: bgcolor,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(size.width * 0.04),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.15,
                                      decoration: BoxDecoration(
                                        color: restaurantClr,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(size.width * 0.04),
                                          topRight: Radius.circular(size.width * 0.04),
                                        ),
                                        image: imageUrl.isNotEmpty
                                            ? DecorationImage(
                                                image: NetworkImage(imageUrl),
                                                fit: BoxFit.scaleDown,
                                                onError: (exception, stackTrace) {
                                                  print("Error loading image: $exception");
                                                },
                                              )
                                            : null,
                                      ),
                                      child: imageUrl.isEmpty
                                          ? Center(child: Text("No image available"))
                                          : null,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(size.width * 0.04),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurantSnap['name'],
                                            style: textstyle.copyWith(
                                              fontSize: size.width * 0.045,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.01),
                                          Text(
                                            restaurantSnap['location'],
                                            style: textstyle.copyWith(
                                              fontSize: size.width * 0.035,
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.02),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  // Commented out rating section
                                                  // Icon(Icons.star, color: Colors.amber, size: size.width * 0.05),
                                                  // SizedBox(width: size.width * 0.01),
                                                  // Text(
                                                  //   "4.5",
                                                  //   style: textstyle.copyWith(fontSize: size.width * 0.035),
                                                  // ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => BookingSeat(
                                                          restaurantName: restaurantSnap['name'],
          restaurantImage: imageUrl,
                                                        )),
                                                  );
                                                },
                                                child: Text(
                                                  "Book Now",
                                                  style: textstyle.copyWith(
                                                    fontSize: size.width * 0.035,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: scaffclr,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(size.width * 0.02),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}