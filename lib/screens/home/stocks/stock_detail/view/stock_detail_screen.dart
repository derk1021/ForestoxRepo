import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tonyyaooo/common_components/white_background_background.dart';
import 'package:tonyyaooo/reusable_widgets/app_bar/custom_appbar.dart';
import 'package:tonyyaooo/reusable_widgets/custom_tab_bar.dart';
import 'package:tonyyaooo/screens/home/stocks/stock_detail/component/stock_detail_component.dart';
import 'package:tonyyaooo/screens/home/stocks/stock_detail/controller/stock_detail_controller.dart';
import 'package:tonyyaooo/utils/constants/constant_lists.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../models/stocks_model/stocks_model.dart';
import '../../../../../reusable_widgets/stock_charts/stock_detail_chart.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen(this.title);

  final StocksModel title;


  @override
  State<StockDetailScreen> createState() => _StockDetailState(title);
}
Future<List<http.Response>> fetchStock() async{


  print("hello trying to select a chord");
  Map<String, String> headers = {
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };
  //http.Response res = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/predict/TSLA'));
  // http.Response res1 = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/tweet_info/TSLA'));
  http.Response res2 = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/getStockPrice/TSLA'));
  res2 = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/getStockPrice/TSLA'));
  res2 = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/getStockPrice/TSLA'));
  ConstantLists.stocksGenerated = true;
  return [res2];
}

class _StockDetailState extends State<StockDetailScreen> {
  late StocksModel stocksModel;

  _StockDetailState(this.stocksModel){}

  @override
  Widget build(BuildContext context) {
    ConstantLists.getStockPrice("TSLA");
    final stockDetailController = Get.find<StockDetailController>();
    return Scaffold(
      appBar: CustomAppBar(
        needBackButton: true,
        needTitle: true,
        needActions: false,
        titleText: stocksModel.corporateName,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: context.height * 1,
        width: context.width * 1,
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
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
                  FutureBuilder<List<http.Response>>(
                      future: fetchStock(),
                      builder: (context, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child:
                              CircularProgressIndicator(
                                color: Colors.blue,
                              )); // Display a loading indicator while waiting for data
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text(
                                  'Error fetching data')); // Display an error message if data fetching fails
                        }else{
                          ConstantLists.stocksModelList[0].price = json.decode(snapshot.data![0].body)[0]["Close"].toString().substring(0,6);

                          return Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    stocksModel.companyImage,
                                    width: 40,
                                    height: 40,
                                  ),
                                  10.pw,
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          stocksModel.companyName,
                                          style: CustomTextStyles.black716,
                                        ),
                                        Text(
                                          stocksModel.corporateName,
                                          style: CustomTextStyles.darkColorTwo412,
                                        ),
                                      ],
                                    ),
                                  ),
                                  5.pw,
                                ],
                              ),
                              20.ph,
                              Align(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$${stocksModel.price}",
                                      style: CustomTextStyles.black636,
                                    ),
                                    10.pw,
                                    PricePercentageRiseWidget(
                                        pricePercentageRaise:
                                        stocksModel.pricePercentageRaise),
                                    5.pw,
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              10.ph,
                              const SizedBox(
                                height: 270,
                                child: StockDetailChart(),
                              ),
                              45.ph,
                              const Text(
                                  "Real-time Analysis and Forecast",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              10.ph,
                              Container(
                                width: 367,
                                height: 70,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF5F7F8),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.black.withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  //padding: const EdgeInsets.all(8.33),
                                  //clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 3.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 25, height: 25, child: Icon(Icons.public, size: 25,)),
                                            10.pw,
                                            const Text('Public Attention: ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 43.0),
                                        child: Row(
                                          children: [
                                            Text(stocksModel.publicAttention, style: const TextStyle(fontSize: 16.5)),
                                            10.pw,
                                            Text(stocksModel.publicPercentageAttention, style: const TextStyle(fontSize: 16.5, color: Colors.green)),
                                            18.pw,
                                            const Text('(Relative High)', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),// public attention widget
                              20.ph,
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF5F7F8),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.black.withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.account_tree_outlined),
                                          10.pw,
                                          const Text(
                                            'Social Media Sentiment:',
                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.ph,
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Column(
                                              children: [
                                                Text(
                                                  '72% Positive',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 93, 156, 89),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                                SizedBox(height: 30,)
                                              ],
                                            ),
                                            10.pw,
                                            Align(
                                              alignment: Alignment.center,
                                              child: CircularPercentIndicator(
                                                radius: 40.0,
                                                animation: true,
                                                animationDuration: 4200,
                                                lineWidth: 15.0,
                                                center: const Icon(Icons.av_timer_outlined),
                                                percent: 0.27,
                                                circularStrokeCap: CircularStrokeCap.round,
                                                backgroundColor: const Color.fromARGB(255, 93, 156, 89),
                                                progressColor: const Color.fromARGB(255, 223, 46, 56),
                                              ),
                                            ),
                                            10.pw,
                                            const Column(
                                              children: [
                                                SizedBox(height: 30,),
                                                Text(
                                                  '27% Negative',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 223, 46, 56),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    10.ph,
                                    const Row(
                                      children: [
                                        Text('Total Posts: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                        Text('3,122', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                                       // Text('  (Within this hour)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                      ],
                                    )
                                  ],
                                ),
                              ), //public sentiment widget
                              20.ph,
                              Container(
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF5F7F8),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.black.withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 30, height: 30, child: Icon(Icons.data_thresholding_outlined, size: 30,)),
                                            10.pw,
                                            const Text(
                                              "Social Score",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Text(
                                          "37.0",
                                          style:  TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "-8.3%",
                                          style:  TextStyle(
                                              fontSize: 27,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Align(alignment: Alignment.topLeft,child: const Text('Score', style: TextStyle(fontWeight: FontWeight.w600),),),
                                    4.ph,
                                    SizedBox(
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 5, 30, 0),
                                        child: LineChart(
                                            LineChartData(
                                                titlesData: FlTitlesData(
                                                    bottomTitles: AxisTitles(
                                                        axisNameWidget: const Align(
                                                          alignment: Alignment.topRight,
                                                          child: Text(
                                                              'Time',
                                                              style: TextStyle(fontWeight: FontWeight.w600)
                                                          ),
                                                        ),
                                                        sideTitles: bottomTitles
                                                    ),
                                                    leftTitles: AxisTitles(
                                                        sideTitles: leftTitles()
                                                    ),
                                                    topTitles: const AxisTitles(
                                                        sideTitles: SideTitles(showTitles: false)
                                                    ),
                                                    rightTitles: const AxisTitles(
                                                        sideTitles: SideTitles(showTitles: false)
                                                    )
                                                ),
                                                gridData: gridData,
                                                borderData: borderData,
                                                lineBarsData: lineBarsData2
                                            )
                                        ),
                                      ),
                                    ),
                                    10.pw,
                                    SizedBox(height: 12,)
                                  ],
                                ),
                              ), // social index graph
                              20.ph,
                              Container(
                                width: 375,
                                height: 70,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF5F7F8),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.black.withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  //padding: const EdgeInsets.all(8.33),
                                  //clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 3.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 25, height: 25, child: Icon(Icons.online_prediction, size: 25,)),
                                            10.pw,
                                            const Text('Prediction Price (For the next hour): ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 43.0),
                                        child: Row(
                                          children: [
                                            Text(stocksModel.predictionPrice, style: const TextStyle(fontSize: 16.5)),
                                            10.pw,
                                            Text(stocksModel.predictionPercentagePrice, style: const TextStyle(fontSize: 16.5, color: Colors.green)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),// prediction price widget
                              20.ph,
                              Container(
                                width: 375,
                                height: 70,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF5F7F8),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.black.withOpacity(0),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  //padding: const EdgeInsets.all(8.33),
                                  //clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 3.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 25, height: 25, child: Icon(Icons.warning_amber_sharp, size: 25,)),
                                            10.pw,
                                            const Text('Social Risk: ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 43.0),
                                        child: Row(
                                          children: [
                                            Text("Unstable", style: const TextStyle(fontSize: 16.5, color: Colors.orange, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              20.ph,
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF5F7F8),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black.withOpacity(0),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "AI Analysis & Suggestions",
                                            style: TextStyle(color: Colors.blue, fontSize: 20),
                                          ),
                                        ),
                                        20.ph,
                                        Text(
                                          stocksModel.aiSuggestionAndAnalysis,
                                          style: CustomTextStyles.black413,
                                          textAlign: TextAlign.justify,
                                        ),
                                        20.ph,
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );

  }

  // Materials...

  LineChartData get sampleData2 => LineChartData(
      lineTouchData: lineTouchData2,
      gridData: gridData,
      titlesData: titlesData2,
      borderData: borderData,
      lineBarsData: lineBarsData2,
      minX: 10,
      maxX: 24,
      maxY: 100,
      minY: 0,
      rangeAnnotations: const RangeAnnotations(

      ),
      clipData:const FlClipData(top: true, bottom: true, left: true, right: true)
  );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: Colors.black.withOpacity(0.7), width: 1.6),
      left: BorderSide(color: Colors.black.withOpacity(0.7), width: 1.6),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineTouchData get lineTouchData2 => const LineTouchData(
    enabled: true,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 9.5:
        text = const Text('9:30', style: style);
        break;
      case 10:
        text = const Text('10:00', style: style);
        break;
      case 11:
        text = const Text('11:00', style: style);
        break;
      case 12:
        text = const Text('12:00', style: style);
        break;
      case 13:
        text = const Text('13:00', style: style);
        break;
      case 14:
        text = const Text('14:00', style: style);
        break;
      case 15:
        text = const Text('15:00', style: style);
        break;
      case 16:
        text = const Text('16:00', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
      case 60:
        text = '60';
      case 70:
        text = '70';
      case 80:
        text = '80';
      case 90:
        text = '90';
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    reservedSize: 20,
  );


  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData2 => [
    lineChartBarData2_1,
  ];

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    color: Colors.blueAccent.withOpacity(0.7),
    barWidth: 2.3,
    isStrokeCapRound: false,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    preventCurveOverShooting: true,
    spots: const [
      FlSpot(9, 0),
      FlSpot(10, 49),
      FlSpot(11, 55),
      FlSpot(12, 42),
      FlSpot(13, 62),
      FlSpot(14, 82),
      FlSpot(15, 52),
      FlSpot(16, 37),
    ],
  );
}
