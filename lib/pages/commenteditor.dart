import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentEditor extends StatelessWidget{
  final TextEditingController commentController = TextEditingController();
  final url = "http://localhost:8080/comment/add";
  Future postcomment(String comment)async{


    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: comment,
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
    // TODO: implement build
    return Stack(
      children:[
        TextField(
            controller: commentController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Comment',
            )),
        Positioned(
          bottom: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: () {

            },
            child: Text('Submit'),
          ),
        )
      ]
    );
  }

}