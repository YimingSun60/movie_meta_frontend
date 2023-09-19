import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class BackendService extends ChangeNotifier {

  List<dynamic> _data = [];
  get data => _data;
  Future fetchData(String name) async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost:8080/$name')
      );

      if (response.statusCode == 200) {
        _data = jsonDecode(response.body);
        //print(data);

        notifyListeners(); // Notify listeners about the change
        return _data;
      } else {
        throw Exception('Failed to load data with status: ${response.statusCode}');
      }
    } catch (error) {
      print(error); // For debugging purposes
      throw Exception('Failed to load data due to network issues.');
    }
  }

// If you stored data, you might want a getter to access it.
//get data => _data;
}







