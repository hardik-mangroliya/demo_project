import 'dart:async';
import 'package:demo_project/user_listController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_model.dart';
import 'package:dio/dio.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserListScreenController userListScreenController =
      Get.put(UserListScreenController());

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
                      // userListScreenController.userlist[index].updatedAt ??
                      ''),
                )))),
      ),
    );
  }
}
