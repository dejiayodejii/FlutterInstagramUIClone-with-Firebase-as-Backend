import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/user_controller.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/services/database.dart';
import 'package:instagram_clone/services/storage.dart';
import 'package:instagram_clone/views/HomeFeed/homefeed_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();

  RxBool loading = false.obs;

  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.userChanges());
  }

  void createUser(String email, String password, String userName,
      String bioDescription, Uint8List? file) async {
    try {
      loading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      String? profilePictureUrl;

      if (file != null) {
         profilePictureUrl =
            await StorageMethods().uploadImageToStorage('profilePicture', file);
      } else {
         profilePictureUrl = '';
      }

      UserModel _user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        userName: userName,
        profileImageUrl:  profilePictureUrl,
        bioDescription: bioDescription,
      );
      if (await DataBase().createNewUser(_user)) {
        Get.find<UserController>().myUserModelValue = _user;
        Get.offAll(() => const HomeFeedScreen());
        loading.value = false;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error creating account",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      loading.value = true;
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().myUserModelValue =
          await DataBase().getUser(_authResult.user!.uid);
      loading.value = false;
      Get.offAll(() => const HomeFeedScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar('Success',
          'check your email and follow the intruction to reset your password',
          duration: const Duration(seconds: 10));
      //Get.offAll(() => LoginOne());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
