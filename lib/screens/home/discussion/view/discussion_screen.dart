import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/models/discussion_model/discussion_model.dart';
import 'package:tonyyaooo/reusable_widgets/app_bar/custom_appbar.dart';
import 'package:tonyyaooo/screens/home/discussion/controller/discussion_controller.dart';
import 'package:tonyyaooo/screens/home/discussion/model/post_model.dart';
import 'package:tonyyaooo/screens/home/post_sharing_screen.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../reusable_widgets/bottom_nav_bar/reusable_bottom_navbar.dart';
import '../../../../reusable_widgets/custom_divider.dart';
import '../../../../service/firestore_service.dart';
import '../../../../utils/constants/constant_lists.dart';
import '../component/discussion_components.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});
  @override
  State<DiscussionScreen> createState() => _DiscussionScreen();
}

class _DiscussionScreen extends State<DiscussionScreen> {
  @override
  Widget build(BuildContext context) {
    final discussionController = Get.find<DiscussionController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // fetchChord();
            Get.off(
              () => const PostSharing(title: "Discuss"),
              transition: Transition.cupertino,
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(CupertinoIcons.plus)),
      appBar: CustomAppBar(
        needActions: true,
        needBackButton: false,
        needTabBar: true,
        tabsList: discussionController.discussionTabs,
        tabOnTapFunction: (index) {
          discussionController.toggleDiscussionTabsList(index);
        },
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        width: context.width * 1,
        height: context.height * 1,
        child: Obx(() {
          return FirestoreListView<PostModel>(
            padding: const EdgeInsets.only(bottom: 60),
            pageSize: 10,
            emptyBuilder: (context) => const Center(
              child: Text('No Posts to show for now!'),
            ),
            loadingBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            query: (discussionController.selectedIndex.value == 1
                    ? FirestoreService.postsCollection
                        .orderBy('createdAt', descending: true)
                        .where('collectedBy',
                            arrayContains:
                                FirebaseAuth.instance.currentUser?.uid ?? 'N?A')
                    : FirestoreService.postsCollection
                        .orderBy('createdAt', descending: true))
                .withConverter(
                    fromFirestore: (snapshot, _) =>
                        PostModel.fromJson(snapshot.data()),
                    toFirestore: (post, _) => post.toJson()),

            // itemCount: posts.length,
            // separatorBuilder: (context, index) =>
            //     const CustomDividerSecond(),
            itemBuilder: (BuildContext context, snapshot) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: DiscussionPostComponent(
                      postModel: snapshot.data(),
                    ),
                  ),
                  const CustomDividerSecond(),
                  // const SizedBox(
                  //   height: 60,
                  // ),
                ],
              );
            },
          );
        }),
      ),
      bottomNavigationBar: const CustomBottomAppBar(selectedIndex: 2),
    );
  }
}
