// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/user_controller.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/services/database.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, this.postModel}) : super(key: key);
  final PostModel? postModel;

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('comments'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 20,
                top: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text(widget.postModel!.caption!)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Flexible(
              child: ListView.builder(
                  controller: _scrollController,
                  physics: ScrollPhysics(
                      parent: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics())),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: const [
                                        TextSpan(
                                            text: 'ayila omowura',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        TextSpan(
                                          text: 'wow!, this is so beautiful ',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      'wow, thats good',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.favorite,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 18,
                ),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (commentController.text.isNotEmpty) {
                        var res = await DataBase().addComment(
                            widget.postModel!.postId!,
                            userController.myUserModel.userName!,
                            commentController.text,
                            userController.myUserModel.profileImageUrl!,
                            userController.myUserModel.id!);

                        setState(() {
                          commentController.text = "";
                        });
                        if (res == true) {
                          Get.snackbar('Succefull', 'comment added');

                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        }
                      }
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
