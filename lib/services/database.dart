// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/user_controller.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/services/storage.dart';
import 'package:uuid/uuid.dart';

class DataBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser!;
  final userController = Get.find<UserController>();

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("posts").doc(user.id).set({
        "id": user.id,
        "userName": user.userName,
        "email": user.email,
        "profileImageUrl": "",
        'bioDescription': user.bioDescription,
        'following': [],
        'followers': [],
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> createPost(String? description, Uint8List file, String userName,
      String profilePictureUrl) async {
    try {
      String postImageUrl =
          await StorageMethods().uploadImageToStorage('posts', file);

      String postId = const Uuid().v1();

      await _firestore.collection("post").doc(postId).set({
        'postId': postId,
        'postImageUrl': postImageUrl,
        'likes': [],
        'comments': [],
        'caption': description ?? '',
        'username': userName,
        'profileImage': profilePictureUrl,
      });

      return true;
    } on Exception catch (e) {
      Get.snackbar('Error', 'failed to take create post $e');
      return false;
    }
  }

  Stream<List<PostModel>> getPost() {
    return _firestore
        .collection('post')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<PostModel> posts = [];
      snapshot.docs.forEach((element) {
        posts.add(PostModel.fromJson(doc: element));
        print('done');
      });
      return posts;
    });
  }

  Future<bool> addComment(String postId, String name, String text,
      String profieImageUrl, String uid) async {
    try {
      String commentId = const Uuid().v1();

      await _firestore
          .collection('post')
          .doc(postId)
          .collection('comments')
          .doc()
          .set({
        'profilePic': profieImageUrl,
        'name': name,
        'uid': uid,
        'text': text,
        'commentId': commentId,
        'datePublished': DateTime.now(),
      });
      print('comment succesful');
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }
}
