import 'package:flutter/material.dart';
import 'package:movie_meta/search_bar.dart';
import 'service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Movie Meta',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 255, 255, 255)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  void toggleFavorite() {
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  //var data = await fetchData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Movie Meta")),
        body: Column(
            children: [
            Search_BarWidget()
    ]));
  }
}

