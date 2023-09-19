import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:provider/provider.dart';

const String searchUrl = "search?title=";

class MoviePage extends StatelessWidget {
  final String title;

  const MoviePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _backendService = Provider.of<BackendService>(context, listen: false);
    print(title);
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          AppBar(
            title: Text(title),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          FutureBuilder(
              future: _backendService
                  .fetchData(searchUrl + Uri.encodeComponent(title)),
              builder: (context, snapshot) {
                //print(searchUrl + Uri.encodeComponent(title));
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return Center(child: Text('No data'));
                } else {
                  return Container(
                      height: 300,
                      child: Column(children: <Widget>[
                        Text(snapshot.data[0]['title']),
                        Text(snapshot.data[0]['genres'].toString()),
                        Expanded(
                          child: Text(snapshot.data[0]['extract']),
                        )
                      ]));
                }
              })
          //Image(image: NetworkImage(movie[0]['thumbnail'])),
        ],
      ),
    );
  }
}
