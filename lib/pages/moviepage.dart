import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:movie_meta/pages/comment_text_field.dart';
import 'package:provider/provider.dart';

import '../basic_widgets/comment_bottom.dart';
import 'movie_comment_list.dart';

const String searchUrl = "public/movie/";

class MoviePage extends StatefulWidget {
  final String title;
  final String id;

  const MoviePage({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    final BackendService backendService = BackendService();

    dynamic movie;

    void refresh() {
      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
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
        floatingActionButton: CommentButtom(
          CommentEditor(
              movieId: widget.id, movieTitle: widget.title, callback: refresh),
        ),
        body: FutureBuilder(
            future: backendService.fetchData(searchUrl + widget.id, false),
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



