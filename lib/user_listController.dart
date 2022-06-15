import 'package:demo_project/api_service.dart';
import 'package:demo_project/user_model.dart';
import 'package:get/get.dart';

class UserListScreenController extends GetxController {
  RxList<User> userlist = <User>[].obs;

  void getUserFromAPI() async {
    userlist.value = await ApiService.getUser();
  }
}
