import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/navigation.dart';
import 'package:movie_meta/basic_widgets/search_bar.dart';
import 'package:provider/provider.dart';
import 'pages/homepage.dart';

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
        home: MainPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  void toggleFavorite() {
    notifyListeners();
  }
}

class MainPage extends StatefulWidget{
  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages =
    [
      MyHomePage(),
      Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: const Text('Page 2'),
      ),
      Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: const Text('Page 3'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Movie Meta")),
      floatingActionButton: SearchButton(),
      bottomNavigationBar: MyNavigationBar(
          onIndexChanged: (index) {
            setState(() => _selectedIndex = index);
            print(_selectedIndex);
          }),
      body: pages[_selectedIndex],
    );
  }
}


