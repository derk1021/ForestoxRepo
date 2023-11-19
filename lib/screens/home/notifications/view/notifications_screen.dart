import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../../../../common_components/white_background_background.dart';
import '../../../../reusable_widgets/app_bar/custom_appbar.dart';
import '../../../../reusable_widgets/bottom_nav_bar/reusable_bottom_navbar.dart';
import '../../../../utils/constants/constant_lists.dart';
import '../controller/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsController = Get.find<NotificationsController>();
    return Scaffold(
      appBar: const CustomAppBar(
        needBackButton: false,
        titleText: "Notifications",
        needTitle: true,
        needActions: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: context.width * 1,
        height: context.height * 1,
        child: AnimationLimiter(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: ConstantLists.notificationModelList.length,
            separatorBuilder: (context, index) => 10.ph,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: WhiteContainerBackground(
                      width: context.width * 1,
                      borderRadius: 15,
                      horizontalPaddingValue: 10,
                      verticalPaddingValue: 10,
                      childWidget: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ConstantLists
                                .notificationModelList[index].imageAsset,
                            width: 38,
                            height: 38,
                          ),
                          10.pw,
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ConstantLists.notificationModelList[index]
                                      .notificationTitle,
                                  style: CustomTextStyles.black613,
                                ),
                                Text(
                                  ConstantLists.notificationModelList[index]
                                      .notificationDescription,
                                  style: CustomTextStyles.darkColorTwo510,
                                ),
                              ],
                            ),
                          ),
                          5.pw,
                          Text(
                            ConstantLists
                                .notificationModelList[index].notificationTime,
                            style: CustomTextStyles.black510,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(selectedIndex: 3),
    );
  }
}
