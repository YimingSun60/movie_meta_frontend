import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget{
  const MoviePage ({Key ? key}) : super(key:key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          AppBar(
            title: Text("Movie Page"),
          ),
          //Image(image: )
        ],
      ),
    );
  }
}