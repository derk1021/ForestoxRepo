import 'package:flutter/material.dart';

import '../utils/colors/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: CColors.dividerColor,
    );
  }
}

class CustomDividerSecond extends StatelessWidget {
  const CustomDividerSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: CColors.scaffoldColorThree,
    );
  }
}
