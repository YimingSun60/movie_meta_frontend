import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_meta/Auth/secure_storage.dart';

import '../Entity/User.dart';
import 'moviepage.dart';

class MyCollection extends StatefulWidget {


  const MyCollection({Key? key}) : super(key: key);

  @override
  _MyCollectionState createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  Future fetchData() async {
    final url = "http://localhost:8080/collection/" + User.id.toString();
    String? token = await SecureStorage.read();
    final response = await http.get(Uri.parse(url),
        headers: {"Authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      dynamic _data = jsonDecode(response.body);
      return _data;
    } else {
      throw Exception(
          'Failed to load data with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Collection"),
      ),
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null) {
              return Center(child: Text('No data'));
            } else {
              print(snapshot.data.length);
              return Column(children: <Widget>[
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            ListTile(
                              title: Text(snapshot.data[index]['title']),
                          onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MoviePage(id: snapshot.data[index]['id'].toString(), title: snapshot.data[index]['title'])));
                          },
                            ),
                            Divider()
                          ]);
                        }))
              ]);
            }
          }),
    );
  }
}
