import 'package:demo_project/api_service.dart';
import 'package:demo_project/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeScreenController extends GetxController {
  RxList<User>? listOfUser = <User>[].obs;
  RxBool isLoading = true.obs;
  void getUserData() async {
    isLoading.value = true;
    listOfUser?.value = await ApiService.getUser();
    isLoading.value = false;
  }
}
