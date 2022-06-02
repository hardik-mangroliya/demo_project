// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:demo_project/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<User>> getUser() async {
    List<User> usersList;
    try {
      // print('User Data:');
      Response userData = await _dio
          .get("https://verified-mammal-79.hasura.app/api/rest/users/0");
      print('User Info: ${userData.data}');
      usersList = apiDataFromJson(jsonEncode(userData.data)).users ?? [];

      return usersList;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio Error');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error Sending Requst');
        print(e.message);
      }
      return [];
    }
  }
}
