import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/reusable_widgets/custom_tab_bar.dart';
import 'package:tonyyaooo/screens/home/profile.dart';
import 'package:tonyyaooo/screens/home/stocks/stocks_landing/view/stocks_landing_screen.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/text_styles/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool needBackButton, needActions, needTitle, centerTitle, needTabBar;
  final String titleText;
  final double appBarHeight;
  final Function(int)? tabOnTapFunction;
  final List<Widget>? tabsList;

  Function testFunction() {
    return tapAvatar();
  }

  const CustomAppBar(
      {Key? key,
      this.needBackButton = true,
      this.needTabBar = false,
      this.needActions = true,
      this.needTitle = false,
      this.centerTitle = false,
      this.titleText = "",
      this.tabsList,
      this.tabOnTapFunction,
      this.appBarHeight = 65})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return AppBar(
      backgroundColor: CColors.whiteColor,
      shadowColor: CColors.blackColor.withOpacity(0.1),
      forceMaterialTransparency: false,
      centerTitle: centerTitle,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      leading: needBackButton
          ? IconButton(
              onPressed: () {
                Get.off(
                      () => const StocksLandingScreen(),
                  transition: Transition.cupertino,
                );
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: CColors.blackColor,
              ),
            )
          : null,
      leadingWidth: 60,
      title: needTitle
          ? Text(
              titleText,
              style: CustomTextStyles.black620,
            )
          : needTabBar
              ? CustomAppBarTab(
                  onTapFunction: (tabOnTapFunction),
                  tabsList: tabsList,
                )
              : null,
      actions: needActions
          ? [
              GestureDetector(
                onTap: () {
                  Get.off(
                    () => const ProfilePage(title: "Profile"),
                    transition: Transition.cupertino,
                  );
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          user?.photoURL.toString() ??
                              "cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxL3JtNjA5LXNvbGlkaWNvbi13LTAwMi1wLnBuZw.webp",
                        ),
                      ),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(80)),
                ),
              ),
              20.pw,
            ]
          : null,
    );
  }

  tapAvatar() {
    print("avatar");
  }
}
