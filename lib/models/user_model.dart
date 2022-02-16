// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? userName;
  String? email;
  String? bioDescription;
  List<dynamic>? following;
  List<dynamic>? followers;

  String? profileImageUrl;

  UserModel(
      {this.id,
      this.userName,
      this.email,
      this.profileImageUrl,
      this.bioDescription,
      this.followers,
      this.following});

  UserModel.fromDocumentSnapshot({DocumentSnapshot? doc}) {
    id = doc!.id;
    userName = doc["userName"];
    bioDescription = doc["bioDescription"];
    email = doc["email"];
    profileImageUrl = doc["profileImageUrl"];
    following = doc["following"];
    followers = doc["followers"];
  }
}
