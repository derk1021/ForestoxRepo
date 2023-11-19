import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tonyyaooo/common_components/white_background_background.dart';
import 'package:tonyyaooo/models/forecast_model/forecast_model.dart';
import 'package:tonyyaooo/reusable_widgets/custom_option_menu/custom_option_menu.dart';
import 'package:tonyyaooo/utils/alignment/widget_alignment.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../utils/colors/app_colors.dart';

class StocksAnalysisAndPredictionBuilderComponent extends StatelessWidget {
  final List<StocksAnalysisAndPredictionsModel> stockAnalysisAndPredictionList;

  const StocksAnalysisAndPredictionBuilderComponent({
    super.key,
    required this.stockAnalysisAndPredictionList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stockAnalysisAndPredictionList.length,
      separatorBuilder: (context, index) => 20.ph,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: StocksAnalysisAndPredictionComponent(
                stocksAnalysisAndPredictionsModel:
                    stockAnalysisAndPredictionList[index],
              ),
            ),
          ),
        );
      },
    );
  }
}

///
class StocksAnalysisAndPredictionComponent extends StatelessWidget {
  final StocksAnalysisAndPredictionsModel stocksAnalysisAndPredictionsModel;

  const StocksAnalysisAndPredictionComponent(
      {super.key, required this.stocksAnalysisAndPredictionsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CColors.scaffoldColorTwo,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  stocksAnalysisAndPredictionsModel.stockAnalysisImage,
                  height: 28,
                  width: 28,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            stocksAnalysisAndPredictionsModel
                                .stockAnalysisCompany,
                            style: CustomTextStyles.black613,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            stocksAnalysisAndPredictionsModel
                                .stockAnalysisCorporateName,
                            style: CustomTextStyles.darkColorTwo510,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          3.pw,
          Expanded(
            flex: 3,
            child: WhiteContainerBackground(
              childWidget: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const StockAnalysisOptionTitleTextWidget(
                    stringText: "Event attention",
                  ),
                  StockAnalysisOptionValueWidget(
                    textWidget: Text(
                      stocksAnalysisAndPredictionsModel.stockAttention,
                      style: CustomTextStyles.black614,
                    ),
                  ),
                ],
              ),
            ),
          ),
          3.pw,
          Expanded(
            flex: 3,
            child: WhiteContainerBackground(
              childWidget: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const StockAnalysisOptionTitleTextWidget(
                    stringText: "Public Polarities",
                  ),
                  StockAnalysisOptionValueWidget(
                    textWidget: Text(
                      stocksAnalysisAndPredictionsModel.stockPolarities,
                      style: stocksAnalysisAndPredictionsModel
                                  .stockPolarities[0] ==
                              "+"
                          ? CustomTextStyles.green614
                          : stocksAnalysisAndPredictionsModel
                                      .stockPolarities[0] ==
                                  "-"
                              ? CustomTextStyles.red614
                              : CustomTextStyles.black614,
                    ),
                  ),
                ],
              ),
            ),
          ),
          3.pw,
          Expanded(
            flex: 2,
            child: WhiteContainerBackground(
              childWidget: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const StockAnalysisOptionTitleTextWidget(
                    stringText: "Prediction",
                  ),
                  StockAnalysisOptionValueWidget(
                    textWidget: Text(
                      stocksAnalysisAndPredictionsModel.prediction,
                      style:
                          stocksAnalysisAndPredictionsModel.prediction == "Rise"
                              ? CustomTextStyles.green612
                              : stocksAnalysisAndPredictionsModel.prediction ==
                                      "Fluctuates"
                                  ? CustomTextStyles.gold608
                                  : CustomTextStyles.black614,
                    ),
                  ),
                ],
              ),
            ),
          ),
          3.pw,
          const Expanded(
            child: StockAnalysisAndMenuMoreOption(),
          ),
        ],
      ),
    );
  }
}

///
class StockAnalysisOptionTitleTextWidget extends StatelessWidget {
  final String stringText;

  const StockAnalysisOptionTitleTextWidget({
    super.key,
    required this.stringText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        child: Text(
          stringText,
          style: CustomTextStyles.black609,
        ),
      ).alignWidget(alignment: Alignment.topCenter),
    );
  }
}

class StockAnalysisOptionValueWidget extends StatelessWidget {
  final Widget textWidget;

  const StockAnalysisOptionValueWidget({
    super.key,
    required this.textWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: textWidget.alignWidget(alignment: Alignment.center),
    );
  }
}
