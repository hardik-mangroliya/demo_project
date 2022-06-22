import 'package:demo_project/core/api_service.dart';
import 'package:demo_project/core/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class HomeScreenController extends GetxController {
  RxList<User> userlist = <User>[].obs;
  RxBool isLoading = true.obs;

  final dbhelper = DatabaseHelper();
  void getUserFromAPI() async {
        isLoading.value = true;

    userlist.value = await dbhelper.getAllRecordFromDB();
    if (userlist.isEmpty) {
      await ApiService.getUser();
      userlist.value = await dbhelper.getAllRecordFromDB();
    }
        isLoading.value = false;

  }

  Future<void> SearchUser(String value) async{
    if(value != ""){
      userlist.value = await dbhelper.search(value);
    }else{
      userlist.value  = await dbhelper.search("");
    }
  }
}