import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {

  final ValueChanged<int>? onIndexChanged;
  const MyNavigationBar({Key? key, this.onIndexChanged}) : super(key: key);



  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar>{
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context){
    return NavigationBar(
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.star), label: 'Favorites'),
        NavigationDestination(
            icon: Icon(Icons.person), label: 'My'),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
          print(_selectedIndex);
        });
        widget.onIndexChanged?.call(index);
      },
      selectedIndex: _selectedIndex,
    );

  }

}

