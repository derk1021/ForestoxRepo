import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/screens/home/discussion/model/post_model.dart';
import 'package:tonyyaooo/utils/constants/constant_lists.dart';

class DiscussionController extends GetxController {
  List<Widget> discussionTabs = const [
    Tab(
      child: Text("For You"),
    ),
    Tab(
      child: Text("Collected"),
    ),
  ];

  RxInt selectedIndex = 0.obs;

  toggleDiscussionTabsList(index) {
    selectedIndex.value = index;
  }

  ///INFO: Use these incase want to manage state globally
  // RxBool isLoading = true.obs;
  // RxList<PostModel> posts = <PostModel>[].obs;
  // RxList<PostModel> collectedPosts = <PostModel>[].obs;
  // late final StreamSubscription postsStream;
  // late final StreamSubscription collectedPostsStream;

  void likeHandler(PostModel post) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    if (post.likedBy?.contains(user.uid) ?? false) {
      post.likedBy = post.likedBy!.where((e) => e != user.uid).toList();
    } else {
      final List<String> likedBy = [...(post.likedBy ?? []), user.uid];
      post.likedBy = likedBy;
    }
    post.update();
  }

  void shareHandler(PostModel post) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    if (post.sharedBy?.contains(user.uid) ?? false) {
      post.sharedBy = post.sharedBy!.where((e) => e != user.uid).toList();
    } else {
      final List<String> sharedBy = [...(post.sharedBy ?? []), user.uid];
      post.sharedBy = sharedBy;
    }
    post.update();
  }

  void collectHandler(PostModel post) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    if (post.collectedBy?.contains(user.uid) ?? false) {
      post.collectedBy = post.collectedBy!.where((e) => e != user.uid).toList();
    } else {
      final List<String> collectedBy = [...(post.collectedBy ?? []), user.uid];
      post.collectedBy = collectedBy;
    }
    post.update();
  }

  @override
  void onInit() {
    ///INFO: Use these incase want to manage state globally

    // postsStream = ConstantLists.postsCollection
    //     .orderBy('createdAt', descending: true)
    //     .snapshots()
    //     .listen((event) {
    //   posts.value = event.docs
    //       .map(
    //         (e) => PostModel.fromJson(e.data()),
    //       )
    //       .toList();
    //   if (isLoading.value) {
    //     isLoading.value = false;
    //   }
    // });
    // collectedPostsStream = ConstantLists.postsCollection
    //     .orderBy('createdAt', descending: true)
    //     .where('collectedBy',
    //         arrayContains: FirebaseAuth.instance.currentUser?.uid ?? 'N?A')
    //     .snapshots()
    //     .listen((event) {
    //   collectedPosts.value = event.docs
    //       .map(
    //         (e) => PostModel.fromJson(e.data()),
    //       )
    //       .toList();
    //   if (isLoading.value) {
    //     isLoading.value = false;
    //   }
    // });
    super.onInit();
  }

  @override
  void dispose() {
    // postsStream.cancel();
    // collectedPostsStream.cancel();
    super.dispose();
  }
}
