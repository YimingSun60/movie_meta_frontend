import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_meta/Auth/secure_storage.dart';



class BackendService extends ChangeNotifier {


  List<dynamic> _data = [];
  get data => _data;
  Future fetchData(String name) async {
    try {
      print(Uri.parse('http://localhost:8080/$name'));
      String? token = await SecureStorage.read();
      //print(await JwtListener().isTokenValid(token!));
      //print(token);
      final response = await http.get(
          Uri.parse('http://localhost:8080/$name'),
        headers:{"Authorization": 'Bearer $token'}
      );

      if (response.statusCode == 200) {
        _data = jsonDecode(response.body);
        

        notifyListeners(); // Notify listeners about the change
        return _data;
      } else {
        throw Exception('Failed to load data with status: ${response.statusCode}');
      }
    } catch (error) {
      //print(error); // For debugging purposes
      throw Exception('Failed to load data due to network issues.');
    }
  }

// If you stored data, you might want a getter to access it.
//get data => _data;

}







