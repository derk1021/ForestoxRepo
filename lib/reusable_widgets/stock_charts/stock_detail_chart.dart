import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tonyyaooo/utils/constants/constant_lists.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/text_styles/text_styles.dart';
import 'package:candlesticks/candlesticks.dart';


class StockDetailChart extends StatefulWidget {
  const StockDetailChart({super.key});

  @override
  State<StockDetailChart> createState() => _StockDetailChartState();

}

class _StockDetailChartState extends State<StockDetailChart> {

  List<Candle> candles = [
  ];
  bool themeIsDark = false;

  @override
  Widget build(BuildContext context) {
    ConstantLists.getPrediction("TSLA");
    setState(() {
      candles = ConstantLists.candles;
    });
    return Center(
      child: Candlesticks(
        candles: candles,
      ),
    );
  }
}
