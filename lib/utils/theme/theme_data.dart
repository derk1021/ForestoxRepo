import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CustomThemeData {
  CustomThemeData._();

  static ThemeData lightViewTheme = ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: CColors.scaffoldColor,
    useMaterial3: true,
  );
}
