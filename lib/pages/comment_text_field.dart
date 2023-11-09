import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Auth/secure_storage.dart';
import '../Entity/User.dart';

class CommentEditor extends StatelessWidget{
  final String movieId;
  final String movieTitle;
  final Function callback;
  CommentEditor({Key? key, required this.movieId, required this.movieTitle, required this.callback}) : super(key: key);
  final TextEditingController commentController = TextEditingController();
  final url = "http://localhost:8080/comment/add";
  Future postcomment(String comment)async{
    var body = jsonEncode({"comment": comment, "userId": User.id, "movieId": movieId,
      "movieTitle": movieTitle, "userName": User.username});
    var token = await SecureStorage.read();
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json",
      "Authorization": "Bearer ${token}"},
      body: body,
    );
    if(response.statusCode == 200){
      print("Comment posted");
    }
    else{
      print("Comment not posted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
        children:[
          TextField(
              controller: commentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comment',
              )),
          ElevatedButton(
            onPressed: () async {
                await postcomment(commentController.text);
                commentController.clear();
                Navigator.pop(context);
                callback();
            },
            child: Positioned(
              bottom: 0,
              right: 0,
              child: Text('Submit'),
            ),
          )
        ]
      ),
    );
  }

}