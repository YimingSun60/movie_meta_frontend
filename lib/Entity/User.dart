import 'dart:ffi';

class User{
  User._();
  static int id = 0;
  static String username = "";
  static String imagePath = "assets/images/download.png";
  static List<dynamic> movies = [];

  static void resetCommentList(){
    movies = [];
  }
  //static String username = "";

}