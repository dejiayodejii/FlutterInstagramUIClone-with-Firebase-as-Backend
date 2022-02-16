import 'package:get/get.dart';
import 'package:instagram_clone/models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel().obs;
  RxBool isLoading = false.obs;

  UserModel get myUserModel => _userModel.value;

  set myUserModelValue(UserModel value) {
    _userModel.value = value;
  }

  void clear() {
    _userModel.value = UserModel();
    isLoading.value = false;
  }
}
