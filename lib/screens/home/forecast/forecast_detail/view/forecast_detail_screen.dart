import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/reusable_widgets/app_bar/custom_appbar.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';

import '../../../../../common_components/real_time_data_container_component.dart';
import '../../../../../common_components/stocks_analysis_and_prediction_component.dart';
import '../../../../../models/forecast_model/forecast_model.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../controller/forecast_detail_controller.dart';

class ForecastDetailScreen extends StatelessWidget {
  final ForecastModel forecastModel;

  const ForecastDetailScreen({
    super.key,
    required this.forecastModel,
  });

  @override
  Widget build(BuildContext context) {
    final forecastDetailController = Get.find<ForecastDetailController>();
    return Scaffold(
      backgroundColor: CColors.whiteColor,
      appBar: CustomAppBar(
        titleText: forecastModel.typeOfForecast,
        needTitle: true,
        needActions: false,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 5,
        ),
        height: context.height * 1,
        width: context.width * 1,
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Image.network(forecastModel.forecastDetailImage),
                  10.ph,
                  Text(
                    forecastModel.forecastTitle,
                    style: CustomTextStyles.black615,
                  ),
                  10.ph,
                  Text(
                    forecastModel.forecastDescription,
                    style: CustomTextStyles.grey413,
                    textAlign: TextAlign.justify,
                  ),
                  20.ph,
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
                                text: forecastModel
                                    .realtimeDataModel.usersReached,
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
                                text:
                                    forecastModel.realtimeDataModel.totalTweets,
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
                                text: forecastModel
                                    .realtimeDataModel.eventInfluence,
                                style: CustomTextStyles.green713,
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
