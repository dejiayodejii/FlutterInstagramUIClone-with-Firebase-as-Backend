import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/views/HomeFeed/homefeed_screen.dart';
import 'package:instagram_clone/views/Login/login.dart';

class Root extends GetWidget<AuthController> {
  const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => (controller.user != null) ? const HomeFeedScreen() : const LoginScreen()
    );
  }
}