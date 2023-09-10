import 'package:flutter/material.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 255, 255, 255)),
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

class MyHomePage extends StatelessWidget{
  //var data = await fetchData();
  @override
  Widget build(BuildContext context){
    return Scaffold(
         body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                return Text(snapshot.data.toString());
              }
              else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } 
            }
            return CircularProgressIndicator();
            
          }
         )
    );
  }
}