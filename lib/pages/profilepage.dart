import 'package:flutter/material.dart';

import '../Auth/secure_storage.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void Logout() async {
      await SecureStorage.empty();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile Page"),
      ),
      body: Stack(
        children: [
          FutureBuilder(future: future, builder: builder)
          Center(
            child: ElevatedButton(onPressed:(){
              Logout();
              Navigator.pop(context);
            }, child: Text("Logout")),
          )
        ],
      )
    );
  }
}