import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_meta/Auth/secure_storage.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:movie_meta/basic_widgets/card.dart';

import '../Auth/jwt_listener.dart';
import '../basic_widgets/global_context_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
final getIt = GetIt.instance;
class _MyHomePageState extends State<MyHomePage> {
  String title = "";
  String image = "";
  String generes = "";
  final BackendService backendService = BackendService();
  void setupServices() {
    getIt.registerSingleton<NavigationService>(NavigationService());
  }
  Future<bool> checkTokenValidity() async {
    String? token = await SecureStorage.read();
    return JwtListener().isTokenValid(token!);
  }
  @override
  Widget build(BuildContext context) {

          return FutureBuilder(
              future: backendService.fetchData("public/home",false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return Center(child: Text('No data'));
                } else {
                  return Column(children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        //print("flag1");
                        generes = "Genres: ";
                        title = snapshot.data[index]['title'];
                        snapshot.data[index]['thumbnail'] != null
                            ? image = snapshot.data[index]['thumbnail']
                            : image = "";
                        snapshot.data[index]['genres']
                            .asMap()
                            .forEach((i, element) {
                          //generes += "Genre: ";
                          if (i == snapshot.data[index]['genres'].length - 1) {
                            generes += element;
                          } else {
                            generes += element + ", ";
                          }
                        });
                        //print(snapshot.data[index]['id']);
                        return MovieCard(
                            title: title,
                            image: image,
                            generes: generes,
                            id: snapshot.data[index]['id'].toString());
                        //return Text("Item 1");
                      },
                    ))
                  ]);
                }
        });
  }
}
