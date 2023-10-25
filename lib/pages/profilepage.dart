

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';

import '../Auth/secure_storage.dart';
import '../Entity/User.dart';
class ProfilePage extends StatefulWidget {
  final Function setLoggedOutCallback;
  const ProfilePage({Key? key, required this.setLoggedOutCallback}) : super(key:key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final BackendService backendService = BackendService();

  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      await SecureStorage.empty();
      widget.setLoggedOutCallback();
      // Optionally, push to a login or home page here.
    }

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   //title: Text("Profile Page"),
      // ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: backendService.fetchData("user/myprofile/202", true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return Center(child: Text('No data'));
                } else {
                  for (int i = 0; i < snapshot.data["comments"].length; i++){
                    User.comments.add(snapshot.data["comments"][i]["comment"]);
                  }
                  User.id = snapshot.data["id"];
                  User.username = snapshot.data["username"];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileWidget(
                        imagePath: User.imagePath
                      )
                    ],
                  );
                }
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _logout,
              child: Text("Logout"),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  const ProfileWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(imagePath),

        ],
      ),
    );
  }

  Widget buildImage(String imagePath) => ClipOval(
    child:Material(
      color: Colors.transparent,
      child: Ink.image(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(
          onTap: () {},
        ),
      ),
    ),
  );
}
