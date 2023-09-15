import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:movie_meta/basic_widgets/Card.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage ({Key ? key}) : super(key:key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final BackendService backendService = BackendService();
  @override
  Widget build(BuildContext context){
    return FutureBuilder(future: backendService.fetchData("root"), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      else
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return MovieCard(title: snapshot.data[index]['title'], image: snapshot.data[index]['thumbnail']);
          },
        );

    });

  }
}
