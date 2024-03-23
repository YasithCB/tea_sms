import 'dart:convert';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:tea_rubber_sms_app/data/model/collection.dart';
import 'package:tea_rubber_sms_app/data/model/customer.dart';

import '../data/constants.dart';

class CollectionRepo {
  Future<Customer?> getTodayOrdersByRegNo(String regNo) async {
    final String url = '$baseUrl/collection/today?regNo=$regNo';

    try {
      final response = await http.get(Uri.parse(url));

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print('getTodayOrdersByRegNo Request Data: $url');
        print('getTodayOrdersByRegNo Response data: $responseData');
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

  Future<bool> saveCollection(Collection collection) async {
  const String url = '$baseUrl/collection';

  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(collection.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Assuming the server returns a boolean indicating success
      return jsonDecode(response.body)['success'];
    } else {
      // Handle error
      return false;
    }
  } catch (e) {
    // Handle exceptions
    if (kDebugMode) {
      print('Error while saving collection: $e');
    }
    return false;
  }
}

}
