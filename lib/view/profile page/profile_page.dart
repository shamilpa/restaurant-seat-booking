import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/unused_bottombar.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/profile_custom.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/login%20page/login_page.dart';
import 'package:restaurant_seat_booking/view/profile%20page/about_us.dart';
import 'package:restaurant_seat_booking/view/profile%20page/cubit/profile_cubit.dart';
import 'package:restaurant_seat_booking/view/profile%20page/privacy_policy.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profileOptions = [
      {'txt': 'Privacy and Policy', 'icon': Icons.privacy_tip_outlined},
      // {'txt': 'Settings', 'icon': Icons.settings},
      {'txt': 'Help & Support', 'icon': Icons.help_outline},
      {'txt': 'About Us', 'icon': Icons.info_outline},
    ];
    return Scaffold(
      backgroundColor: scaffclr,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: textstyle.copyWith(fontSize: 28,fontWeight: FontWeight.w600),
        ),
        backgroundColor: bgcolor,
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(context)..editName(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is CurrentName) {
              return Column(
                children: [
                  40.hBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        final usernameCtr =
                            TextEditingController(text: state.username);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromRGBO(116, 81, 45, 1.0),
                              title: Text("Edit Username",style: textstyle),
                              content: TextField(
                              style: TextStyle(color: Colors.white),
                                controller: usernameCtr,
                                decoration: InputDecoration(
                                  
                                    hintText: "Enter new username",hintStyle:textstyle),
                              ),
                              actions: [
                                TextButton(
                                  child: Text("Cancel",
                              style: textstyle,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Save",
                              style: textstyle,
                                  ),
                                  onPressed: () {
                                    // context
                                    //     .read<ProfileCubit>()
                                    //     .updateName(usernameCtr.text);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(
                                    'assets/images/profile.jpg'), // Add profile image 
                              ),
                            ),
                            Text(
                              state.username,
                              style: textstyle.copyWith(fontSize: 26,fontWeight: FontWeight.w600)
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 255, 234, 220),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  20.hBox,
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final List<Map<String, dynamic>> profileOptions = [
                          {
                            'txt': 'Privacy and Policy',
                            'icon': Icons.privacy_tip_outlined
                          },
                          {'txt': 'Help & Support', 'icon': Icons.help_outline},
                          {'txt': 'About Us', 'icon': Icons.info_outline},
                        ];

                        if (index == profileOptions.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 25),
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.logout,
                                          size: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Logout",
                                          style: textstyle.copyWith(fontSize: 15,fontWeight: FontWeight.w600)
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      await LocalStorage
                                          .deleteData(); // Ensure deleteData is a method
                                      print("User logged out");
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          final option = profileOptions[index];
                          return ProfileDetails(
                            txt: option['txt'],
                            icon: option['icon'],
                            onTAp: () {
                              if (option['txt'] == 'Privacy and Policy') {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PrivacyAndPolicy(),
                                ));
                              } else if (option['txt'] == 'About Us') {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AboutUs(),
                                ));
                              }
                            },
                          );
                        }
                      },
                      itemCount: 3 + 1, // 3 options + 1 logout
                      separatorBuilder: (context, index) => 3.hBox,
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
