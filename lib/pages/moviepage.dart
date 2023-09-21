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
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
            future: _backendService
                .fetchData(searchUrl + Uri.encodeComponent(title)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null) {
                return Center(child: Text('No data'));
              } else {
                return Stack(children: <Widget>[
                  Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: NetworkImage(snapshot.data[0]['thumbnail']),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox.expand(
                    child: MovieDragableScrollableSheet(
                        text: snapshot.data[0]['extract'].toString()),
                  )
                ]);
              }
            }));
  }
}

class MovieDragableScrollableSheet extends StatelessWidget {
  final String text;

  const MovieDragableScrollableSheet({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            child: Material(
              color: Colors.white,
              elevation: 100.0,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      leading: CircleAvatar(child: Text('A')),
                      title: Text("HeadLine"),
                    ),
                    Divider()
                  ]);
                },
              ),
            ));
      },
    );
  }
}
