import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_seat_booking/local_storage.dart';
import 'package:restaurant_seat_booking/view%20model/color_component.dart';
import 'package:restaurant_seat_booking/view%20model/profile_custom.dart';
import 'package:restaurant_seat_booking/view%20model/text_style.dart';
import 'package:restaurant_seat_booking/view/login%20page/login_page.dart';
import 'package:restaurant_seat_booking/view/profile%20page/about_us.dart';
import 'package:restaurant_seat_booking/view/profile%20page/cubit/profile_cubit.dart';
import 'package:restaurant_seat_booking/view/profile%20page/privacy_policy.dart';
import 'dart:convert';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  void _updateUsername(BuildContext context, String newUsername) {
    context.read<ProfileCubit>().updateName(newUsername);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profileOptions = [
      {'txt': 'Privacy and Policy', 'icon': Icons.privacy_tip_outlined},
      {'txt': 'Help & Support', 'icon': Icons.help_outline},
      {'txt': 'About Us', 'icon': Icons.info_outline},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: scaffclr,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Profile",
                style: textstyle.copyWith(
                    fontSize: 28, fontWeight: FontWeight.w600),
              ),
              backgroundColor: bgcolor,
            ),
            body: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return Column(
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: screenHeight * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: screenHeight * 0.045,
                                      backgroundImage: state.profileImage !=
                                              null
                                          ? MemoryImage(
                                              base64Decode(state.profileImage!))
                                          : null,
                                      child: state.profileImage == null
                                          ? Icon(Icons.person,
                                              size: screenHeight * 0.05,
                                              color: Colors.white)
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () => context
                                            .read<ProfileCubit>()
                                            .pickImage(),
                                        child: CircleAvatar(
                                          radius: screenHeight * 0.02,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: screenHeight * 0.03,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.username,
                                  style: textstyle.copyWith(
                                      fontSize: screenHeight * 0.028,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 255, 234, 220),
                                      size: screenHeight * 0.03,
                                    ),
                                    onPressed: () {
                                      final usernameCtr = TextEditingController(
                                          text: state.username);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return AlertDialog(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    116, 81, 45, 1.0),
                                            title: Text("Edit Username",
                                                style: textstyle),
                                            content: TextField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              controller: usernameCtr,
                                              decoration: InputDecoration(
                                                hintText: "Enter new username",
                                                hintStyle: textstyle,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text("Cancel",
                                                    style: textstyle),
                                                onPressed: () {
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text("Save",
                                                    style: textstyle),
                                                onPressed: () {
                                                  _updateUsername(context,
                                                      usernameCtr.text);
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 255, 234, 220),
                                      size: screenHeight * 0.03,
                                    ),
                                    onPressed: () => context
                                        .read<ProfileCubit>()
                                        .removeProfilePicture(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (index == profileOptions.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: screenHeight * 0.03),
                                child: Column(
                                  children: [
                                    Container(
                                      width: screenWidth * 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: // Inside the ProfilePage class
                                          ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.logout,
                                                  size: screenHeight * 0.02,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "Logout",
                                              style: textstyle.copyWith(
                                                  fontSize: screenHeight * 0.02,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        onTap: () async {
                                          try {
                                            await LocalStorage.deleteData();
                                            print("User logged out");
                                            if (context.mounted) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()),
                                                (Route<dynamic> route) => false,
                                              );
                                            }
                                          } catch (e) {
                                            print("Error during logout: $e");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Logout failed. Please try again.")),
                                            );
                                          }
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => PrivacyAndPolicy(),
                                    ));
                                  } else if (option['txt'] == 'About Us') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AboutUs(),
                                    ));
                                  }
                                },
                              );
                            }
                          },
                          itemCount: profileOptions.length + 1,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: screenHeight * 0.01),
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
      ),
    );
  }
}
