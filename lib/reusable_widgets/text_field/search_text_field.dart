import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/assets.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/text_styles/text_styles.dart';

class SearchTextField extends StatelessWidget {
  final Function(String)? onChangedFunction;
  final TextEditingController textEditingController;
  final String hintText;
  final double width, height;

  const SearchTextField({
    Key? key,
    this.width = 250,
    this.height = 50,
    this.hintText = "Search Meat Here..",
    this.onChangedFunction,
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
        cursorColor: CColors.blueColor,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          suffixIcon: Center(
            child: SvgPicture.asset(Assets.searchIconSearchIcon),
          ),
          suffixIconConstraints: const BoxConstraints(
            maxWidth: 50,
            minWidth: 50,
          ),
          hintText: hintText,
          hintStyle: CustomTextStyles.hintTextStyle513,
          enabled: true,
          filled: true,
          errorStyle: const TextStyle(
            fontSize: 0,
          ),
          fillColor: CColors.whiteColor,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CColors.searchFormBorderColor),
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
            borderSide: BorderSide(color: CColors.searchFormBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CColors.searchFormBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: CColors.searchFormBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
        ),
        onChanged: onChangedFunction,
      ),
    );
  }
}
