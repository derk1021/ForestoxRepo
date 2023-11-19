import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/common_components/real_time_data_container_component.dart';
import 'package:tonyyaooo/common_components/stocks_analysis_and_prediction_component.dart';
import 'package:tonyyaooo/utils/alignment/widget_alignment.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../../../../../models/forecast_model/forecast_model.dart';
import '../../../../../reusable_widgets/custom_divider.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../forecast_detail/view/forecast_detail_screen.dart';

class ForeCastDisplayWidget extends StatelessWidget {
  final ForecastModel forecastModel;

  const ForeCastDisplayWidget({super.key, required this.forecastModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CColors.whiteColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 20,
            spreadRadius: 0.0,
            color: CColors.blackColor.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      forecastModel.dateOfForecast,
                      style: CustomTextStyles.natoBlack410,
                    ),
                    5.ph,
                    Text(
                      forecastModel.forecastTitle,
                      style: CustomTextStyles.black715,
                    ).paddingOnly(right: 50),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    forecastModel.forecastImage,
                    width: 160,
                  ).alignWidget(alignment: Alignment.centerRight),
                ),
              ),
            ],
          ),
          10.ph,
          const CustomDivider(),
          10.ph,
          const Text(
            "Real-time data:",
            style: CustomTextStyles.black713,
          ),
          10.ph,
          Wrap(
            spacing: 10,
            runSpacing: 5,
            children: [
              RealTimeDataContainerComponent(
                widget: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                          text: "Users reached: ",
                          style: CustomTextStyles.robotoBlack713),
                      TextSpan(
                        text: forecastModel.realtimeDataModel.usersReached,
                        style: CustomTextStyles.robotoBlack413,
                      ),
                    ],
                  ),
                ),
              ),
              RealTimeDataContainerComponent(
                widget: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                          text: "Total Tweets: ",
                          style: CustomTextStyles.robotoBlack713),
                      TextSpan(
                        text: forecastModel.realtimeDataModel.totalTweets,
                        style: CustomTextStyles.robotoBlack413,
                      ),
                    ],
                  ),
                ),
              ),
              RealTimeDataContainerComponent(
                widget: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                          text: "Event influence: ",
                          style: CustomTextStyles.robotoBlack713),
                      TextSpan(
                        text: forecastModel.realtimeDataModel.eventInfluence,
                        style: CustomTextStyles.black713,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          20.ph,
          const Text(
            "Stocks Analysis & Predictions",
            style: CustomTextStyles.black713,
          ),
          10.ph,
          StocksAnalysisAndPredictionBuilderComponent(
            stockAnalysisAndPredictionList:
                forecastModel.stockAnalysisAndPredictionList,
          ),
          10.ph,
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Get.to(() => ForecastDetailScreen(forecastModel: forecastModel),
                  transition: Transition.fadeIn);
            },
            child: const Text(
              "View more",
              style: CustomTextStyles.blue713,
            ).paddingSymmetric(horizontal: 5),
          ).alignWidget(alignment: Alignment.centerRight),
        ],
      ),
    );
  }
}
