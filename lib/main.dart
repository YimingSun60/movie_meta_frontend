import 'package:flutter/material.dart';
import 'package:movie_meta/basic_widgets/navigation.dart';
import 'package:movie_meta/basic_widgets/search_bar.dart';
import 'package:movie_meta/basic_widgets/service.dart';
import 'package:movie_meta/pages/collection_page.dart';
import 'package:movie_meta/pages/mypage.dart';
import 'package:provider/provider.dart';
import 'basic_widgets/global_context_service.dart';
import 'pages/homepage.dart';
import 'package:get_it/get_it.dart';

void main() {
  final getIt = GetIt.instance;


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MyAppState()),
      ChangeNotifierProvider(create: (context) => BackendService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Movie Meta',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 255, 255, 255)),
        ),
        home: MainPage());
  }
}

class MyAppState extends ChangeNotifier {
  void toggleFavorite() {
    notifyListeners();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MyHomePage(),
      MyCollection(),
      MyPage(),
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Movie Meta")),
      floatingActionButton: SearchButton(),
      bottomNavigationBar: MyNavigationBar(onIndexChanged: (index) {
        setState(() => _selectedIndex = index);
        //print(_selectedIndex);
      }),
      body: pages[_selectedIndex],
    );
  }
}
