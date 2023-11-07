import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:provider/provider.dart';

const String searchUrl = "public/movie/";

class MoviePage extends StatelessWidget {
  final String title;
  final String id;

  //const MoviePage({Key? key, required this.title}) : super(key: key);
  const MoviePage({Key? key, required this.id, required this.title})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final BackendService backendService = BackendService();
    //print(id);
    dynamic movie;
    return Scaffold(
        appBar: AppBar(
          title: Text(title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono')),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
            future: backendService.fetchData(searchUrl + id, false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print("error");
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null) {
                return Center(child: Text('No data'));
              } else {
                movie = snapshot.data;
                print(movie["comments"].length);
                return Stack(children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: NetworkImage(snapshot.data['thumbnail']),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      minChildSize: 0.3,
                      maxChildSize: 1,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, -5),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "Extract",
                                    style: TextStyle(
                                      wordSpacing: 2.0,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RobotoMono',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    snapshot.data['extract'],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'RobotoMono',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox.expand(
                      child: MovieDragableScrollableSheet(movie: movie))
                ]);
              }
            }));
  }
}

class MovieDragableScrollableSheet extends StatelessWidget {
  //final String text;
  final dynamic movie;
  const MovieDragableScrollableSheet({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, -5),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: movie["comments"].length > 0
              ? ListView.builder(
                  controller: scrollController,
                  itemCount: movie["comments"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        leading: CircleAvatar(
                            child: Text(
                                movie["comments"][index]["username"].toString().capitalize()[0])),
                        title: Text(
                            movie["comments"][index]["comment"].toString()),
                      ),
                      Divider()
                    ]);
                  },
                )
              : Center(
                  child: Text(
                  "No comments",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'RobotoMono',
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                )),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}