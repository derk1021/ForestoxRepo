import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../../../../../utils/colors/app_colors.dart';

class PricePercentageRiseWidget extends StatelessWidget {
  final String pricePercentageRaise;

  const PricePercentageRiseWidget(
      {super.key, required this.pricePercentageRaise});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: pricePercentageRaise[0] == "-"
            ? CColors.redColor.withOpacity(0.1)
            : CColors.greenColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            pricePercentageRaise[0] == "-"
                ? Icons.arrow_downward_rounded
                : Icons.arrow_upward_rounded,
            color: pricePercentageRaise[0] == "-"
                ? CColors.redColor
                : CColors.greenColor,
            size: 15,
          ),
          5.pw,
          Text(
            pricePercentageRaise,
            style: CustomTextStyles.green510,
          )
        ],
      ),
    );
  }
}

class PredictionPriceWidget extends StatelessWidget {
  final String predictionPrice, predictionPercentagePrice;

  const PredictionPriceWidget({
    super.key,
    required this.predictionPrice,
    required this.predictionPercentagePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CColors.scaffoldColorTwo,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            predictionPrice,
            style: CustomTextStyles.black520,
          ),
          20.pw,
          Text(
            predictionPercentagePrice,
            style: predictionPercentagePrice == "+"
                ? CustomTextStyles.green520
                : predictionPercentagePrice == "-"
                    ? CustomTextStyles.red520
                    : CustomTextStyles.green520,
          ),
        ],
      ),
    );
  }
}
