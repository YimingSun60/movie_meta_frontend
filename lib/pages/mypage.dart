import 'package:flutter/material.dart';
import 'package:movie_meta/Auth/jwt_listener.dart';
import 'package:movie_meta/Auth/secure_storage.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:http/http.dart' as http;
import 'package:movie_meta/pages/profilepage.dart';

import 'Login.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>{
  JwtListener jwtListener = JwtListener();
  BackendService backendService = BackendService();

  static bool isLoggedIn = false;
  void setLoggedIn(){
    setState(() {
      isLoggedIn = true;
    });
  }

  void setLoggedOut(){
    setState(() {
      isLoggedIn = false;
    });
  }

  Future<bool> checkTokenValidity() async {
    String? token = await SecureStorage.read();
    if(token == null || token == "No data found"){
      return false;
    }
    else {
      bool valid = await JwtListener().isTokenValid(token!);
      return valid;
    }
  }
  Future<String> fetchData() async {
    String? token = await SecureStorage.read();
    final response = await http.get(
        Uri.parse('http://localhost:8080/user/myprofile'),
        headers:{"Authorization": 'Bearer $token'}
    );
    if(response.statusCode==200){
      return response.body;
    }
    else{
      throw Exception('Failed to load data with status: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context){
    print(isLoggedIn);
    return Scaffold(
      body: isLoggedIn ? ProfilePage(setLoggedOutCallback: setLoggedOut) : Login(setLoggedInCallback:setLoggedIn),
    );

}}