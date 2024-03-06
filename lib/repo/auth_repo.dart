import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../data/db.dart';

class AuthRepo {
  Future<bool> sendAuthReq(BuildContext context, username, password) async {
    final dio = Dio();

    var requestData = {
      'username': username.trim(),
      'password': password.toLowerCase().trim(),
    };

    var headers = {
      'Accept': 'application/json',
      'Origin': 'https://sf-timesheet-admin-2.ceyentra.lk',
    };

    try {
      final response = await dio.post(
        '$baseUrl/login',
        options: Options(headers: headers),
        data: requestData,
      );

      final responseData = response.data;

      if (kDebugMode) {
        print('Request Data: $requestData');
        print('Response status: ${response.statusCode}');
        print('Response data: $responseData');
      }

      final responseDataBody = responseData['body'];

      if (responseData['success']) {
        accessToken = responseDataBody['access_token'];
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
