import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tea_rubber_sms_app/data/model/customer.dart';

import '../data/constants.dart';

class UserRepo {
  Future<Customer?> searchUserByRegNo(String regNo) async {
    final String url = '$baseUrl/customer/search?regNo=$regNo';

    try {
      final response = await http.get(Uri.parse(url));

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print('Request Data: $url');
        print('Response data: $responseData');
      }

      if (response.statusCode == 200) {

        return Customer.fromJson(responseData['body']);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Err while searchUserByNic : $e');
      }
      return null;
    }
  }
}
