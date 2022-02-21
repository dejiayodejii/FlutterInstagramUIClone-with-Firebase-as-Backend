// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/controller/user_controller.dart';
import 'package:instagram_clone/services/database.dart';
import 'package:instagram_clone/utilities/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  //XFile? _file;
  Uint8List? _file;
  final TextEditingController? descriptionController = TextEditingController();
  final userController = Get.find<UserController>();
  var controller = Get.find<PostController>();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    descriptionController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;

    return _file == null
        ? Center(
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('Take a photo'),
                        children: [
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Take from Camera'),
                            onPressed: () async {
                              Navigator.of(context).pop;

                              Uint8List? file = await PostController()
                                  .pickImage(ImageSource.camera);
                              setState(() {
                                _file = file;
                              });
                            },
                          ),
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Take from Gallery'),
                            onPressed: () async {
                              Navigator.of(context).pop;
                              Uint8List? file = await PostController()
                                  .pickImage(ImageSource.gallery);
                              setState(() {
                                _file = file;
                              });
                            },
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text('New post'),
              centerTitle: false,
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    _file = null;
                  });
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });

                    controller
                        .postImage(descriptionController!.text, _file!)
                        .whenComplete(
                          () => setState(() {
                            isLoading = false;
                            _file = null;
                          }),
                        );
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  isLoading
                      ? const LinearProgressIndicator(
                          color: Colors.blue,
                        )
                      : const Padding(padding: EdgeInsets.only(top: 0.0)),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: width,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                              image: MemoryImage(_file!),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Write a caption...',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
