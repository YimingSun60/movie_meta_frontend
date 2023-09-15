import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget{
  final String title;
  final String image;
  const MovieCard({Key? key, required this.title, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      child: Column(
        children: [
          Image.network(image),
          Text(title)
        ],
      ),
    );
  }
}