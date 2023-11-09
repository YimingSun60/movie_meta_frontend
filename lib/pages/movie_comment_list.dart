import 'package:flutter/material.dart';
import 'package:movie_meta/pages/moviepage.dart';


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}


class MovieDragableScrollableSheet extends StatefulWidget {
  final dynamic movie;
  const MovieDragableScrollableSheet({super.key, required this.movie});

  @override
  State<MovieDragableScrollableSheet> createState() =>
      _MovieDragableScrollableSheetState();
}

class _MovieDragableScrollableSheetState
    extends State<MovieDragableScrollableSheet> {
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
          child: widget.movie["comments"].length > 0
              ? ListView.builder(
            controller: scrollController,
            itemCount: widget.movie["comments"].length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  leading: CircleAvatar(
                      child: Text(widget.movie["comments"][index]
                      ["username"]
                          .toString()
                          .capitalize()[0])),
                  title: Text(widget.movie["comments"][index]["comment"]
                      .toString()),
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