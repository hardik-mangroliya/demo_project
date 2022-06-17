import 'package:demo_project/api_service.dart';
import 'package:demo_project/model/sqLite_model.dart';
import 'package:demo_project/user_model.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxList<User> userlist = <User>[].obs;
  final dbhelper = DatabaseHelper();
  void getUserFromAPI() async {
    userlist.value = await dbhelper.getAllRecordFromDB();
    if (userlist.isEmpty) {
      await ApiService.getUser();
      userlist.value = await dbhelper.getAllRecordFromDB();
    }
  }
}
