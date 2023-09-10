import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



Future fetchData() async {
  final response = await http.get(Uri.parse(Uri.encodeFull('http://localhost:8080/The Gentlemen')));

  if (response.statusCode == 200) {
    // Parse the JSON data
    var data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

