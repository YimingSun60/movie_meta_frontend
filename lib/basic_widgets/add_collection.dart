import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import '../Auth/secure_storage.dart';

class CollectionBottom extends StatefulWidget {
  final int userId;
  final String movieId;
  CollectionBottom(this.userId, this.movieId);
  @override
  State<CollectionBottom> createState() => _CollectionBottomState();
}

class _CollectionBottomState extends State<CollectionBottom> {
  late var _userId;
  late var _movieId;
  @override
  void initState() {
    super.initState();
    _userId = widget.userId;
    _movieId = widget.movieId;
  }
  bool isLiked = false;

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    var urlAdd = Uri.parse('http://localhost:8080/public/collection_add');
    var urlDelete = Uri.parse('http://localhost:8080/public/collection_remove');
    Uri url;
    if(isLiked == false){
      url = urlAdd;
      isLiked = true;
    }
    else{
      url = urlDelete;
      isLiked = false;
    }
    var body = jsonEncode({'userId': _userId, 'movieId': _movieId});
    String? token = await SecureStorage.read();
    final response = await http.post(
      url, body:body,
      headers: {"Content-Type": "application/json", "Authorization": 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      if(isLiked == false){
        print("Collection removed");
      }
      else{
        print("Collection added");
      }
    } else {
      print("Failed");
    }

    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return isLiked;
  }

  @override
  Widget build(context) {
    return LikeButton(
      size: 30,
      circleColor:
      CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      onTap: onLikeButtonTapped,
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.redAccent : Colors.grey,
          size: 30,
        );
      },
    );

  }
}