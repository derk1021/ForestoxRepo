import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../../../service/firestore_service.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../../auth/model/user_model.dart';
import '../model/comment_model.dart';
import '../model/post_model.dart';
import 'discussion_components.dart';

class CommentComponent extends StatelessWidget {
  final CommentModel comment;
  final PostModel post;
  const CommentComponent(
      {super.key, required this.comment, required this.post});
  handleCommentLike(CommentModel comment) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    if (comment.likedBy?.contains(user.uid) ?? false) {
      comment.likedBy = comment.likedBy!.where((e) => e != user.uid).toList();
    } else {
      final List<String> likedBy = [...(comment.likedBy ?? []), user.uid];
      comment.likedBy = likedBy;
    }
    comment.update(post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<UserModel?>(
            stream: FirestoreService.usersCollection
                .doc(comment.userId!)
                .snapshots()
                .map(
                  (event) => UserModel.fromJson(
                    event.data(),
                  ),
                ),
            builder: (context, snapshot) {
              final user = snapshot.data;
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          user?.userName ?? comment.userName ?? 'N/A',
                          style: CustomTextStyles.black613,
                        ),
                        Text(
                          (comment.createdAt?.toDate() ?? DateTime.now())
                              .toString(),
                          style: CustomTextStyles.darkColorTwo410,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          comment.content ?? 'N/A',
                          style: CustomTextStyles.black513,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  PostActionComponent(
                    iconString: Assets.appIconsHeartIcon,
                    number: comment.likedBy?.length ?? 0,
                    color: comment.likedBy?.contains(
                                FirebaseAuth.instance.currentUser?.uid ??
                                    'N/A') ??
                            false
                        ? Colors.pink
                        : null,
                    onTapFunction: () {
                      handleCommentLike(comment);
                    },
                  ),
                ],
              );
            }),
        const Divider()
      ],
    );
  }
}
