// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/views/CommentScreen/comment_screen.dart';

class FeedBodyScreen extends StatelessWidget {
  FeedBodyScreen({Key? key}) : super(key: key);

  final controller = Get.find<AuthController>();
  //final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: mobileBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 48,
            width: 100,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: primaryColor,
            ),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: GetX<PostController>(
          init: PostController(),
          builder: (controller) {
            return controller.allPosts.isEmpty
                ? const Center(
                    child: Text('No Post to display'),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //height: 150,
                        //color: Colors.redAccent,
                        width: double.infinity,
                        child: Column(
                          children: [
                            //postcard header
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 6)
                                  .copyWith(right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text('Instablog9ja'),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.more_vert))
                                ],
                              ),
                            ),
                            //post images
                            Container(
                              height: height * 0.4,
                              width: double.infinity,
                              child: Image.network(
                                controller.allPosts[0].postImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            //cooment,like and bookmark buttons
                            Row(
                              children: [
                                IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: const Icon(
                                      Icons.comment_outlined,
                                    ),
                                    onPressed: () {
                                      Get.to(() => CommentScreen(
                                            postModel: controller.allPosts[0],
                                          ));
                                    }),
                                IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                    ),
                                    onPressed: () {}),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        icon: const Icon(Icons.bookmark_border),
                                        onPressed: () {}),
                                  ),
                                ),
                              ],
                            ),
                            //likes count,comment and post descriotion
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('485 likes'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style:
                                          const TextStyle(color: primaryColor),
                                      children: [
                                        const TextSpan(
                                          text: 'Instablog9ja ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: controller.allPosts[0].caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'View all 1,1234 ',
                                    style: TextStyle(
                                        color: secondaryColor, fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => CommentScreen(
                                              postModel: controller.allPosts[0],
                                            ));
                                      },
                                      child: const Text(
                                        'Add a comment',
                                        style: TextStyle(
                                            color: secondaryColor,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
