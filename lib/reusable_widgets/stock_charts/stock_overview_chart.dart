import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../../utils/colors/app_colors.dart';

class StockOverviewChart extends StatelessWidget {
  StockOverviewChart({required this.priceData});
  List<FlSpot> priceData;

  @override
  Widget build(BuildContext context) {
    double minYrange, maxYrange;
    if (priceData[0].y==168.86){minYrange =166; maxYrange=169;}
    else if (priceData[0].y>400){ minYrange = 410; maxYrange=463;}
    else if (priceData[0].y>300){ minYrange = 300; maxYrange=325;}
    else{minYrange = 210; maxYrange = 225;}

    List<Color> gradientColors = [
      const Color(0xffe68823),
      const Color(0xffe68823),
    ];

    return LineChart(
      LineChartData(
        titlesData: const FlTitlesData(
            show: false
        ),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: true
        ),
        minX: 0,
        maxX: 20,
        minY: minYrange,
        maxY: maxYrange,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 4,
            tooltipBgColor: CColors.whiteColor,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                return LineTooltipItem(
                  "\$${touchedSpot.y.toString()}",
                  CustomTextStyles.darkColorThree710,
                  children: const [
                    TextSpan(
                      text: "\n",
                    ),
                    TextSpan(
                      text: "28 Oct 2023 - 22:00",
                      style: CustomTextStyles.greyAccentThree510,
                    ),
                    TextSpan(
                      text: "\n",
                    ),
                    TextSpan(
                      text: "Volume: 102K",
                      style: CustomTextStyles.greyAccentThree510,
                    ),
                  ],
                  textAlign: TextAlign.left,
                );
              }).toList();
            },
          ),

        ),

        lineBarsData: [
          LineChartBarData(
            spots: priceData,
            isCurved: true,
            color: CColors.blueColor,
            barWidth: 1.5,
            isStrokeCapRound: false,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(0.1),
                      Colors.red.withOpacity(0.05),
                    ]
                ),
            ),
          ),
        ],
      ),
    );
  }
}
