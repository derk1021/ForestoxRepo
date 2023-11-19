import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../../utils/colors/app_colors.dart';

class SocialOverChart extends StatelessWidget {
  SocialOverChart({required this.socialData});
  List<FlSpot> socialData;

  @override
  Widget build(BuildContext context) {

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
        maxX: 13,
        minY: 0,
        maxY: 100,
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
            spots: socialData,
            isCurved: false,
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
                      Colors.green.withOpacity(0.1),
                      Colors.green.withOpacity(0.05),
                    ]
                ),
            ),
          ),
        ],
      ),
    );
  }
}
