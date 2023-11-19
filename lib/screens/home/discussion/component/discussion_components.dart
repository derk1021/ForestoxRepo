import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/generated/assets.dart';
import 'package:tonyyaooo/models/discussion_model/discussion_model.dart';
import 'package:tonyyaooo/screens/auth/model/user_model.dart';
import 'package:tonyyaooo/screens/home/discussion/controller/discussion_controller.dart';
import 'package:tonyyaooo/screens/home/discussion/model/post_model.dart';
import 'package:tonyyaooo/screens/home/discussion/view/single_post_screen.dart';
import 'package:tonyyaooo/utils/constants/constant_lists.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';

import '../../../../service/firestore_service.dart';
import '../../../../utils/text_styles/text_styles.dart';

class DiscussionPostComponent extends StatelessWidget {
  final PostModel postModel;

  const DiscussionPostComponent({
    super.key,
    required this.postModel,
  });

  getImage(url, context) {
    if (url != null) {
      precacheImage(NetworkImage(url), context);
      return Hero(
        tag: url,
        child: Image.network(
          url,
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscussionController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<UserModel?>(
            stream: FirestoreService.usersCollection
                .doc(postModel.userId!)
                .snapshots()
                .map(
                  (event) => UserModel.fromJson(
                    event.data(),
                  ),
                ),
            builder: (context, snapshot) {
              final user = snapshot.data;
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image(
                      image: user?.imageUrl != null
                          ? NetworkImage(user!.imageUrl!)
                          : const AssetImage(
                                  Assets.notificationImagesNitificationImageOne)
                              as ImageProvider,
                      width: 38,
                      height: 38,
                    ),
                  ),
                  10.pw,
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.userName ?? postModel.userName ?? 'N/A',
                          style: CustomTextStyles.black613,
                        ),
                        Text(
                          (postModel.createdAt?.toDate() ?? DateTime.now())
                              .toString(),
                          style: CustomTextStyles.darkColorTwo410,
                        ),
                      ],
                    ),
                  ),
                  5.pw,
                ],
              );
            }),
        10.ph,
        Text(
          postModel.content ?? 'N/A',
          style: CustomTextStyles.black415,
        ),
        10.ph,
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: getImage(postModel.imageUrl, context),
        ),
        10.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: PostActionComponent(
                iconString: Assets.appIconsHeartIcon,
                number: postModel.likedBy?.length ?? 0,
                color: postModel.likedBy?.contains(
                            FirebaseAuth.instance.currentUser?.uid ?? 'N/A') ??
                        false
                    ? Colors.pink
                    : null,
                onTapFunction: () => controller.likeHandler(postModel),
              ),
            ),
            Expanded(
              flex: 3,
              child: StreamBuilder(
                  stream: FirestoreService.postCommentsCollection(postModel.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return PostActionComponent(
                      iconString: Assets.appIconsCommentsIcon,
                      number: snapshot.data?.docs.length ?? 0,
                      onTapFunction: () {
                        Get.to(() => SinglePostScreen(post: postModel));
                      },
                    );
                  }),
            ),
            Expanded(
              flex: 3,
              child: PostActionComponent(
                iconString: Assets.appIconsShareIcon,
                number: postModel.sharedBy?.length ?? 0,
                color: postModel.sharedBy?.contains(
                            FirebaseAuth.instance.currentUser?.uid ?? 'N/A') ??
                        false
                    ? Colors.blue.shade900
                    : null,
                onTapFunction: () => controller.shareHandler(postModel),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () => controller.collectHandler(postModel),
                icon: SvgPicture.asset(Assets.appIconsSaveIcon,
                    height: 18,
                    width: 18,
                    color: postModel.collectedBy?.contains(
                                FirebaseAuth.instance.currentUser?.uid ??
                                    'N/A') ??
                            false
                        ? Colors.yellow.shade900
                        : null),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class PostActionComponent extends StatelessWidget {
  final String iconString;
  final int number;
  final Function()? onTapFunction;
  final Color? color;

  const PostActionComponent(
      {super.key,
      required this.iconString,
      required this.number,
      required this.onTapFunction,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          color: Colors.red,
          isSelected: true,
          onPressed: onTapFunction,
          icon: SvgPicture.asset(
            iconString,
            height: 18,
            width: 18,
            color: color,
          ),
        ),
        Text(
          number.toString(),
          style: color != null
              ? CustomTextStyles.grey413
              : CustomTextStyles.grey413.copyWith(color: color),
        ),
        10.pw,
      ],
    );
  }
}
