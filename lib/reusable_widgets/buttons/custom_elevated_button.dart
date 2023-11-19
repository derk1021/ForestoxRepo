import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/text_styles/text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressedFunction;
  final String buttonText;
  final double height, width;
  final bool isBlue, isSocialMediaButton, isGoogleLogIn, isAppleLogIn;

  const CustomElevatedButton({
    super.key,
    required this.onPressedFunction,
    this.buttonText = "",
    required this.width,
    this.height = 50,
    this.isBlue = false,
    this.isSocialMediaButton = false,
    this.isGoogleLogIn = false,
    this.isAppleLogIn = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        fixedSize: Size(
          width,
          height,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        backgroundColor: isBlue
            ? CColors.blueColor
            : isSocialMediaButton
                ? CColors.whiteAccentColor
                : CColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: isSocialMediaButton
          ? SvgPicture.asset(
              isGoogleLogIn
                  ? Assets.socialMediaIconsGoogleLogo
                  : isAppleLogIn
                      ? Assets.socialMediaIconsAppleLogo
                      : Assets.socialMediaIconsGoogleLogo,
              height: 20,
              width: 20,
            )
          : Text(
              buttonText,
              style: isBlue
                  ? CustomTextStyles.white613
                  : CustomTextStyles.white613,
            ),
    );
  }
}
