import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/constants.dart';
import '../data/db.dart';

class AuthRepo {
//   Future<bool> sendAuthReq(BuildContext context, username, password) async {
//     final dio = Dio();

//     var requestData = {
//       'username': username.trim(),
//       'password': password.toLowerCase().trim(),
//     };

//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//     };

//     try {
//       final response = await dio.post(
//         '$baseUrl/authenticate',
//         options: Options(headers: headers),
//         data: jsonEncode(requestData),
//       );

//       final responseData = response.data;

//       if (kDebugMode) {
//         print('Request Data: $requestData');
//         print('Response data: $responseData');
//       }

//       final responseDataBody = responseData['body'];

//       if (response.statusCode == 200) {
//         accessToken = responseDataBody['jwt'];
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Err while auth : $e');
//       }
//       return false;
//     }
//   }

  Future<bool> sendAuthReq(String username, String password) async {
    var requestData = {
      'userName': username.trim(),
      'password': password.toLowerCase().trim(),
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/authenticate'),
        headers: headers,
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print('Request Data: $requestData');
        print('Response data: $responseData');
      }

      if (responseData['success']) {
        accessToken = responseData['body']['jwt'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Err while auth : $e');
      }
      return false;
    }
  }
}
