import 'dart:convert';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:tea_rubber_sms_app/data/model/collection.dart';

import '../data/constants.dart';

class CollectionRepo {
  Future<List<Collection>> getTodayCollectionsByRegNo(String regNo) async {
    final String url = '$baseUrl/collection/today?regNo=$regNo';

    try {
      final response = await http.get(Uri.parse(url));

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print('getTodayCollectionsByRegNo Request Data: $url');
        print('getTodayCollectionsByRegNo Response data: $responseData');
      }

      if (response.statusCode == 200) {
        return [];
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Err while searchUserByNic : $e');
      }
      return [];
    }
  }

  Future<List<Collection>> getAllCollectionsByRegNo(String regNo) async {
    final String url = '$baseUrl/collection/today?regNo=$regNo';

    try {
      final response = await http.get(Uri.parse(url));

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print('getAllCollectionsByRegNo Request Data: $url');
        print('getAllCollectionsByRegNo Response data: $responseData');
      }

      if (response.statusCode == 200) {
        return [];
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Err while searchUserByNic : $e');
      }
      return [];
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

  Future<bool> deleteCollection(String id) async {
    final String url = '$baseUrl/collection/record?collectionId=$id';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while saving collection: $e');
      }
    }
    return false;
  }
}
