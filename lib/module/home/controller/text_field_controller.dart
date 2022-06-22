import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../core/dbHelper.dart';
import '../model/user_model.dart';

class TextFieldController extends GetxController{
    final dbhelper = DatabaseHelper();
  insertdata({required String id,required String bio,required int favourite})async{
   await dbhelper.update(User(bio: bio,id: id,favourite: favourite),);
  }


}



















