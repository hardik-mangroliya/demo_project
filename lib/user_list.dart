import 'dart:async';
import 'package:demo_project/core/dbHelper.dart';
// import 'package:demo_project/module/home/view/controller/home_screenController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'model/user_model.dart';
import 'package:dio/dio.dart';

import 'module/home/controller/home_screenController.dart';
import 'module/home/model/user_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  // final SqliteModel sqliteModel;
  final User user;

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  HomeScreenController userListScreenController =
      Get.put(HomeScreenController());

  @override
  void initState() {
    userListScreenController.getUserFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(() => ListView.builder(
            itemCount: userListScreenController.userlist.length,
            itemBuilder: ((context, index) => Container(
                  child: Text(userListScreenController.userlist[index].email ??
                      userListScreenController.userlist[index].firstName ??
                      userListScreenController.userlist[index].lastName ??
                      userListScreenController.userlist[index].id ??
                      ''),
                )))),
      ),
    );
  }
}
