import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:provider/provider.dart';
import '/pages/moviepage.dart';

const String searchUrl = "search?title=";

class MovieCard extends StatelessWidget {
  final String title;
  final String image;
  final String generes;
  final String id;

  const MovieCard({Key? key, required this.title, required this.image, required this.generes, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // give it a fixed height or any value you desire
      width: 100,
      child: Card(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.black.withAlpha(30),
          // You can use any widget in place of `Placeholder`
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: image != ""
                    ? Image.network(image,
                        width: 100,
                        fit: BoxFit.contain,
                        alignment: Alignment(-1.0, -1.0))
                    : Placeholder(
                        fallbackHeight: 200.0, fallbackWidth: double.infinity),
              ),
              Flexible(
                child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(textAlign: TextAlign.center,title,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
                        ),
                      ),
                      Center(
                        child: Text(textAlign: TextAlign.center,generes,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
                        ),
                      ),
                    ]),
              )
            ],
          ),
          onTap: () {
            var backendService = Provider.of<BackendService>(context, listen: false);
            print(title);
            backendService.fetchData(searchUrl + Uri.encodeComponent(title));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MoviePage(id: id, title: title)),
            );
          },
        ),
      ),
    );
  }
}
