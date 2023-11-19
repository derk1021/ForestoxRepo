import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:tonyyaooo/screens/home/discussion/model/post_model.dart';
import 'package:tonyyaooo/screens/home/discussion/view/discussion_screen.dart';
import 'package:tonyyaooo/service/firestore_service.dart';
import 'package:tonyyaooo/service/storage_service.dart';
import 'package:tonyyaooo/utils/constants/constant_lists.dart';

enum ButtonState { init, loading, done }

class PostSharing extends StatefulWidget {
  const PostSharing({super.key, required this.title});

  final String title;

  @override
  State<PostSharing> createState() => _PostSharingState();
}

class _PostSharingState extends State<PostSharing> {
  final TextEditingController textController = TextEditingController();
  ButtonState state = ButtonState.init;
  bool isAnimating = true;
  final StorageService _storageService = StorageService();

  uploadPostToFirebase() async {
    if (textController.text.isEmpty) {
      return;
    }
    if (isUploading) {
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    isUploading = true;

    String? imageURL;

    // Create a storage reference from our app

    if (file != null) {
      try {
        imageURL = await _storageService.uploadImage(file!, user!.uid);
      } catch (error) {
        print(error);
      }
    }
    final postDocRef = FirestoreService.postsCollection.doc();
    final post = PostModel(
      id: postDocRef.id,
      userId: user.uid,
      userName: user.displayName,
      createdAt: Timestamp.now(),
      imageUrl: imageURL,
      content: textController.text,
      likedBy: [],
      sharedBy: [],
      collectedBy: [],
    ).toJson();

    // final post = <String, Object>{
    //   "sender": user?.displayName ?? "Unknown",
    //   "email": user?.email ?? "Unknown",
    //   "time": date,
    //   "body": textController.text,
    //   "imageURL": imageURL,
    //   "likeNumber": 0,
    //   "commentNumber": 0,
    //   "shareNumber": 0
    // };

    postDocRef
        .set(post)
        .whenComplete(() => () {
              print("complete");
              textController.clear();
              file = null;
            })
        .onError((e, _) => print("Error writing document: $e"));
  }

  Widget buildButton() => OutlinedButton(
        style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(60),
            shape: const StadiumBorder(),
            side: const BorderSide(width: 2, color: Colors.indigo)),
        onPressed: () async {
          setState(() => state = ButtonState.loading);
          await uploadPostToFirebase();
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(seconds: 3));
          setState(() => state = ButtonState.init);
        },
        child: const FittedBox(
          child: Text("Share",
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 24,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600)),
        ),
      );

  Widget buildSmallButton(bool isDone) {
    final color = isDone ? Colors.green : Colors.indigo;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: isDone
            ? const Icon(
                Icons.done,
                size: 52,
                color: Colors.white,
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  var db = FirebaseFirestore.instance;
  XFile? file;
  var isUploading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isStretched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Get.off(() => const DiscussionScreen(),
              transition: Transition.fade),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Text(
                    "Share, discuss, ask anything about stocks",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: SizedBox(
                  height: 130, // <-- TextField height
                  child: TextField(
                    controller: textController,
                    //cursorColor: Colors.blue,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20),
                        hintText: "What's happening...",
                        hintStyle: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                          icon: file != null
                              ? Image.file(
                                  File(file!.path),
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.add_photo_alternate_sharp),
                          iconSize: 90,
                          onPressed: () async {
                            ImagePicker imagepicker = ImagePicker();
                            XFile? image1 = await imagepicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              file = image1;
                            });
                          },
                        ),
                        if (file != null)
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  file = null;
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              ))
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  width: state == ButtonState.init ? width : 70,
                  onEnd: () => setState(() => isAnimating = !isAnimating),
                  height: 60,
                  child: isStretched ? buildButton() : buildSmallButton(isDone),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
