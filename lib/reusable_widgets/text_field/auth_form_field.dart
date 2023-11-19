import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tonyyaooo/generated/assets.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/text_styles/text_styles.dart';

class AuthFormField extends StatelessWidget {
  final String? Function(String?)? validatorFunction;
  final TextEditingController textEditingController;
  final String hintText;
  final double width, height;
  final bool isEmailField, isPasswordField, obscureText;
  final Function()? obscureTextFunction;

  const AuthFormField({
    Key? key,
    this.width = 250,
    this.height = 50,
    this.hintText = "",
    this.isEmailField = false,
    this.isPasswordField = false,
    this.obscureText = false,
    this.obscureTextFunction,
    required this.validatorFunction,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        style: CustomTextStyles.black513,
        keyboardType: isEmailField
            ? TextInputType.emailAddress
            : isPasswordField
                ? TextInputType.text
                : TextInputType.text,
        cursorColor: CColors.blueColor,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 50,
            minWidth: 50,
          ),
          prefixIcon: SvgPicture.asset(
            isEmailField
                ? Assets.authIconsEmailIccon
                : isPasswordField
                    ? Assets.authIconsPasswordIcon
                    : "",
          ),
          suffixIconConstraints: isPasswordField
              ? const BoxConstraints(
                  maxWidth: 50,
                  minWidth: 50,
                )
              : null,
          suffixIcon: isPasswordField
              ? InkWell(
                  onTap: obscureTextFunction,
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: CColors.blueColor,
                  ),
                )
              : null,
          hintText: hintText,
          hintStyle: CustomTextStyles.hintTextStyle513,
          enabled: true,
          filled: true,
          errorStyle: const TextStyle(
            fontSize: 0,
          ),
          fillColor: CColors.whiteColor,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CColors.authFormBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CColors.authFormBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CColors.authFormBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: CColors.authFormBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
        ),
        validator: validatorFunction,
      ),
    );
  }
}
