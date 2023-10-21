import 'service.dart';
import 'package:flutter/material.dart';

const String searchUrl = "public/search?title=";

class SearchButton extends StatelessWidget{

  @override
  Widget build(context){
    return FloatingActionButton(
      child: Icon(Icons.search),
      onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate())
    );
  }

}

class MovieSearchDelegate extends SearchDelegate {
  final BackendService backendService = BackendService();


  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions for the app bar, like clearing the search query
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '', // Clear the search query
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    // Leading icon on the left of the app bar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null), // Close the search delegate
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    late Future resultsFuture;
    //print(searchUrl + query);
    resultsFuture = backendService.fetchData(searchUrl + Uri.encodeComponent(query));
    // Show some result based on the selection
    return FutureBuilder(future: resultsFuture, builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data[index]['title']),
            );
          },
        );

    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    late Future resultsFuture;
    //print(searchUrl + query);
    resultsFuture = backendService.fetchData(searchUrl + Uri.encodeComponent(query));
    return FutureBuilder(future: resultsFuture, builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data[index]['title']),
            );
          },
        );

    });
  }
}