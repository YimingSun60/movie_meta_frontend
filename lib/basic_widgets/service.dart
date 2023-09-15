import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class BackendService extends ChangeNotifier {

  //var _data = [];
  Future fetchData(String name) async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost:8080/${name}')
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // You can store the data locally if needed
        // _data = data;

        notifyListeners(); // Notify listeners about the change
        return data;
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







