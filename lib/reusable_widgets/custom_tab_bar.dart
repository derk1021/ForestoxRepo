import 'package:flutter/material.dart';
import 'package:tonyyaooo/utils/alignment/widget_alignment.dart';

import '../utils/colors/app_colors.dart';
import '../utils/text_styles/text_styles.dart';

class CustomAppBarTab extends StatelessWidget {
  final Function(int)? onTapFunction;
  final List<Widget>? tabsList;

  const CustomAppBarTab({
    super.key,
    required this.onTapFunction,
    required this.tabsList,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsList!.length,
      child: TabBar(
        onTap: onTapFunction,
        isScrollable: true,
        labelColor: CColors.blueColor,
        dividerColor: Colors.transparent,
        unselectedLabelColor: CColors.blackColor,
        indicatorColor: CColors.blueColor,
        labelStyle: CustomTextStyles.blue615,
        unselectedLabelStyle: CustomTextStyles.black415,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            width: 5.0,
            color: CColors.blueColor,
          ),
        ),
        tabs: tabsList!,
      ),
    ).alignWidget(
      alignment: Alignment.centerLeft,
    );
  }
}

class StockGraphTabBar extends StatelessWidget {
  final Function(int)? onTapFunction;
  final List<Widget>? tabsList;

  const StockGraphTabBar({
    super.key,
    required this.onTapFunction,
    required this.tabsList,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsList!.length,
      child: TabBar(
        onTap: onTapFunction,
        isScrollable: false,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        indicatorWeight: 1,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: CColors.blueColor,
        dividerColor: Colors.transparent,
        unselectedLabelColor: CColors.blackColor,
        indicatorColor: CColors.blueColor,
        labelStyle: CustomTextStyles.blue612,
        unselectedLabelStyle: CustomTextStyles.black412,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(
            width: 1,
            color: CColors.blueColor,
          ),
        ),
        tabs: tabsList!,
      ),
    ).alignWidget(
      alignment: Alignment.centerLeft,
    );
  }
}
