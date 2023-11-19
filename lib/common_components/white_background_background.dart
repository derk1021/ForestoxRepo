import 'package:flutter/material.dart';

import '../utils/colors/app_colors.dart';

class WhiteContainerBackground extends StatelessWidget {
  final double borderRadius, verticalPaddingValue, horizontalPaddingValue;
  final double? height, width;
  final Widget? childWidget;

  const WhiteContainerBackground({
    super.key,
    this.borderRadius = 8,
    this.horizontalPaddingValue = 2,
    this.verticalPaddingValue = 5,
    this.width,
    this.height,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: CColors.whiteColor,
      ),
      padding: EdgeInsets.symmetric(
          vertical: verticalPaddingValue, horizontal: horizontalPaddingValue),
      child: childWidget,
    );
  }
}
