import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? caption;
  List? comments;
  List? likes;
  String? postImage;
  String? username;
  String? profileImageUrl;
  String? postId;

  PostModel({
    this.caption,
    this.comments,
    this.likes,
    this.postImage,
    this.profileImageUrl,
    this.username,
    this.postId,
  });

  PostModel.fromJson({QueryDocumentSnapshot? doc}) {
    caption = doc!['caption'];
    comments = doc['comments'];
    likes = doc['likes'];
    postImage = doc['postImageUrl'];
    username = doc['username'];
    profileImageUrl = doc['profileImage'];
    postId = doc['postId'];

  }
}
