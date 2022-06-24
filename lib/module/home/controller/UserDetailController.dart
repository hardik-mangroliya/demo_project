// ignore_for_file: file_names

import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../core/dbHelper.dart';
import '../model/user_model.dart';

class UserDetailController extends GetxController{
    DatabaseHelper dbHelper = DatabaseHelper();
  updateBioDetail({required String id,required String bio})async{
   await dbHelper.update(User(bio: bio,id: id),);
  }
  
  void updateFavouriteDetail({required User userData }) async{
    await dbHelper.update(User(favourite: userData.favourite,id: userData.id));
  }
}



















