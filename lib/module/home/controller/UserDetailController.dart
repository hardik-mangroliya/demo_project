// ignore_for_file: file_names

import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../core/dbHelper.dart';
import '../model/user_model.dart';

class UserDetailController extends GetxController{
    DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> updateUserDetail({required User userData})async{
    await dbHelper.update(User(favourite: userData.favourite,bio: userData.bio,id: userData.id));
  }
}



















