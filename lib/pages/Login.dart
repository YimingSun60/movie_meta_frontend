import 'package:flutter/material.dart';
import 'package:movie_meta/Auth/jwt_listener.dart';
import 'package:movie_meta/Auth/secure_storage.dart';
import 'package:movie_meta/pages/profilepage.dart';

import '../main.dart';


class Login extends StatefulWidget{
  const Login({Key? key}) : super(key:key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  JwtListener jwtListener = JwtListener();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String token = await jwtListener.getNewToken(_usernameController.text, _passwordController.text);
              print(token);
              await SecureStorage.empty();
              await SecureStorage.write(token);

              Navigator.push(context,createRoute(ProfilePage()));
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }


}