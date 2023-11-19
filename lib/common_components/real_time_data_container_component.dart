import 'package:flutter/material.dart';

import '../utils/colors/app_colors.dart';

class RealTimeDataContainerComponent extends StatelessWidget {
  final Widget widget;

  const RealTimeDataContainerComponent({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CColors.scaffoldColorTwo,
      ),
      child: widget,
    );
  }
}
