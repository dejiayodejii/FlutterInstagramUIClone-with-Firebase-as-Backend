import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/controller/user_controller.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/services/database.dart';

class PostController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  final _auth = FirebaseAuth.instance.currentUser!;
  final userController = Get.find<UserController>();
  RxBool loading = false.obs;
  var allPosts = <PostModel>[].obs;


  @override
  void onInit() {
    allPosts.bindStream(DataBase().getPost());
    super.onInit();
  }




  Future pickImage(ImageSource source) async {
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return _file.readAsBytes();
    }
    Get.snackbar('Error', 'failed to take image');
  }

  Future<bool> postImage(
    String? description,
    Uint8List file,
  ) async {
    try {
      loading.value = true;
      print(loading.value);

      userController.myUserModelValue = await DataBase().getUser(_auth.uid);
      String username = userController.myUserModel.userName!;
      String profilePictureUrl = userController.myUserModel.profileImageUrl!;

      if (await DataBase()
          .createPost(description!, file, username, profilePictureUrl)) {
        loading.value = false;
        print(loading.value);
      } else {}

      return true;
    } on Exception catch (e) {
      Get.snackbar('Error', 'failed to take create post $e');
      return false;
    }
  }
}
