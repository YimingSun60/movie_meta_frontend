import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

class JwtListener{

  bool isTokenExpired(String token){
    final decodedToken = JwtDecoder.decode(token);
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
    return DateTime.now().isAfter(expiryDate);
  }

  //login
  Future<String> getNewToken(String username, String password) async{
    var url = Uri.parse('http://localhost:8080/auth/login');
    var body = jsonEncode({'username': username, 'password': password});
    print(body);
    final response = await http.post(
      url, body: body,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String token = data['token'];
      return token;
    } else {
      throw Exception('Failed to load data with status: ${response.statusCode}');
    }
  }

}

