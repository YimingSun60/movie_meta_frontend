import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:movie_meta/basic_widgets/Card.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage ({Key ? key}) : super(key:key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  String title = "";
  String image = "";
  String generes = "";
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
      else if (snapshot.data == null) {
        return Center(child: Text('No data'));
      }
      else {
        return Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      generes = "";
                      title = snapshot.data[index]['title'];
                      snapshot.data[index]['thumbnail'] != null
                          ? image = snapshot.data[index]['thumbnail']
                          : image = "";
                      snapshot.data[index]['genres'].asMap().forEach((i,element) {
                        generes += "Genre: ";
                        if(i == snapshot.data[index]['genres'].length - 1){
                          generes += element;
                        }
                        else{
                          generes += element + ", ";
                        }
                      });
                      return MovieCard(title: title, image: image, generes: generes);
                      //return Text("Item 1");
                    },
                  )
              )
            ]
        );
      }


    });

  }
}
