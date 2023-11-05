import "package:flutter/material.dart";
import "package:movie_meta/pages/moviepage.dart";

import "../Entity/User.dart";

class CommentPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: User.movies.length,
          itemBuilder: (context, index) {
            print(User.movies.length);
              return ListTile(
                title: Text(User.movies[index]['movieTitle'].toString()),
                subtitle: Text(User.movies[index]['comment']),
                onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePage(id: User.movies[index]['movieId'], title: User.movies[index]['movieTitle']))),
              );
            },
        ),
      ),
    );
  }
}
