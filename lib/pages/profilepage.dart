
import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:movie_meta/pages/profile_comment_history.dart';

import '../Auth/secure_storage.dart';
import '../Entity/User.dart';

class ProfilePage extends StatefulWidget {
  final Function setLoggedOutCallback;

  const ProfilePage({Key? key, required this.setLoggedOutCallback})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final BackendService backendService = BackendService();

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      await SecureStorage.empty();
      widget.setLoggedOutCallback();
      // Optionally, push to a login or home page here.
    }

    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: backendService.fetchData(
                "user/myprofile/${User.id}", true),
            builder: (context, snapshot) {
              //User.resetCommentList();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null) {
                return Center(child: Text('No data'));
              } else {
                User.movies = snapshot.data["comments"];
                User.id = snapshot.data["id"];
                User.username = snapshot.data["username"];
                return Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      ProfileWidget(imagePath: User.imagePath),
                      const SizedBox(height: 24),
                      Text(User.username,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 34)),
                      const SizedBox(height: 5),
                      Text("UID: ${User.id}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 24),
                      ListTile(
                        title: Text("Comments"),
                        subtitle: Text("View your comments"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Center(
            child: ElevatedButton(
              onPressed: logout,
              child: Text("Logout"),
            ),
          ),
          const SizedBox(height: 10),
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
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 150, maxWidth: 150),
            child: buildImage(imagePath),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String imagePath) => ClipOval(
        child: Material(
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
