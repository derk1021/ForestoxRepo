import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/screens/home/discussion/view/discussion_screen.dart';
import 'package:tonyyaooo/screens/home/notifications/view/notifications_screen.dart';
import 'package:tonyyaooo/screens/home/stocks/stocks_landing/view/stocks_landing_screen.dart';

import '../../models/bottom_navigation_bar_model/bottom_navigation_bar_model.dart';
import '../../screens/home/forecast/forecast_landing/view/forecast_landing_screen.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/constants/constant_lists.dart';
import '../../utils/text_styles/text_styles.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomAppBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),

      child: BottomAppBar(
        color: CColors.whiteColor,
        height: 70,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int index = 0;
                index < ConstantLists.bottomBarList.length;
                index++) ...[
              BottomNavBarComponent(
                selectedIndex: selectedIndex,
                bottomBarModel: ConstantLists.bottomBarList[index],
              )
            ]
          ],
        ),
      ),
    );
  }
}

class BottomNavBarComponent extends StatelessWidget {
  final int selectedIndex;
  final BottomNavigationBarModel bottomBarModel;

  const BottomNavBarComponent({
    super.key,
    required this.selectedIndex,
    required this.bottomBarModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        12,
      ),
      onTap: selectedIndex == bottomBarModel.itemIndex
          ? null
          : bottomBarModel.itemIndex == 0
              ? () {
                  Get.offAll(
                    () => const StocksLandingScreen(),
                    transition: Transition.fadeIn,
                  );
                }
              : bottomBarModel.itemIndex == 1
                  ? () {
                      Get.offAll(
                        () => const ForecastLandingScreen(),
                        transition: Transition.fadeIn,
                      );
                    }
                  : bottomBarModel.itemIndex == 2
                      ? () {
                          Get.offAll(
                            () => const DiscussionScreen(),
                            transition: Transition.fadeIn,
                          );
                        }
                      : bottomBarModel.itemIndex == 3
                          ? () {
                              Get.offAll(
                                () => const NotificationsScreen(),
                                transition: Transition.fadeIn,
                              );
                            }
                          : () {},
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              bottomBarModel.assetString,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                selectedIndex == bottomBarModel.itemIndex
                    ? CColors.blueColor
                    : CColors.greyAccentColor,
                BlendMode.srcIn,
              ),
            ),
            Text(
              bottomBarModel.title,
              style: selectedIndex == bottomBarModel.itemIndex
                  ? CustomTextStyles.blue610
                  : CustomTextStyles.greyAccent610,
            ),
          ],
        ),
      ),
    );
  }
}
