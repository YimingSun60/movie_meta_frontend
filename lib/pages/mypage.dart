import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:movie_meta/basic_widgets/jwt_listener.dart';

import '../Entity/User.dart';

class Mypage extends StatefulWidget{
  const Mypage({Key? key}) : super(key:key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage>{
  JwtListener jwtListener = JwtListener();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              User.token = await jwtListener.getNewToken(_usernameController.text, _passwordController.text);
              print(User.token);
              // Validate returns true if the form is valid, or false otherwise.
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}