import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tonyyaooo/screens/home/discussion/component/discussion_components.dart';
import 'package:tonyyaooo/screens/home/discussion/model/comment_model.dart';
import 'package:tonyyaooo/screens/home/discussion/model/post_model.dart';
import '../../../../service/firestore_service.dart';
import '../component/comment_component.dart';

class SinglePostScreen extends StatelessWidget {
  final PostModel post;
  SinglePostScreen({super.key, required this.post});
  final TextEditingController textController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              controller: scrollController,
              children: [
                StreamBuilder<PostModel>(
                    initialData: post,
                    stream: FirestoreService.postsCollection
                        .doc(post.id)
                        .snapshots()
                        .map((event) => PostModel.fromJson(event.data())),
                    builder: (context, snapshot) {
                      return DiscussionPostComponent(
                        postModel: snapshot.data!,
                      );
                    }),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: FirestoreService.postCommentsCollection(post.id)
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final List<CommentModel> comments = snapshot
                                  .data?.docs
                                  .map((e) => CommentModel.fromJson(e.data()))
                                  .toList() ??
                              [];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (comments.isEmpty)
                                const Text(
                                  ' No comments',
                                  textAlign: TextAlign.center,
                                ),
                              ...comments
                                  .map(
                                    (comment) => CommentComponent(
                                        comment: comment, post: post),
                                  )
                                  .toList(),
                            ],
                          );
                      }
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              child: TextField(
                // onTap: () =>
                //     Future.delayed(const Duration(milliseconds: 500)).then(
                //   (value) => scrollController.animateTo(
                //       scrollController.position.maxScrollExtent,
                //       duration: const Duration(milliseconds: 500),
                //       curve: Curves.linear),
                // ),
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.name,
                controller: textController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          if (textController.text.isEmpty) return;
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) return;
                          await CommentModel(
                            createdAt: Timestamp.now(),
                            likedBy: [],
                            content: textController.text,
                            userId: user.uid,
                            userName: user.displayName ?? 'N/A',
                          ).setComment(post.id);
                          textController.clear();
                        },
                        icon: const Icon(Icons.send)),
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                    hintText: "What's on your mind...",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
