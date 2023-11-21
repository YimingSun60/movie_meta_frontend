import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/add_collection.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:movie_meta/pages/comment_text_field.dart';

import '../Entity/User.dart';
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
              movieId: widget.id,
              movieTitle: widget.title,
              callback: refresh),
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
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: <Widget>[
                        //Movie poster
                        SizedBox(
                          child: Container(
                            color: Colors.white,
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                            child: Image(
                              image: NetworkImage(snapshot.data['thumbnail']),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        CollectionBottom(User.id,widget.id),
                        //Movie extract
                        Padding(
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
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoMono',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ]),
                    ),
                    MovieDragableScrollableSheet(movie: movie)
                  ],
                );
              }
            }));
  }
}
