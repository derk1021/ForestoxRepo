import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tonyyaooo/reusable_widgets/text_field/search_text_field.dart';
import 'package:tonyyaooo/utils/constants/constant_lists.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../../../../../generated/assets.dart';
import '../../../../../models/forecast_model/forecast_model.dart';
import '../../../../../reusable_widgets/app_bar/custom_appbar.dart';
import '../../../../../reusable_widgets/bottom_nav_bar/reusable_bottom_navbar.dart';
import '../component/forecast_landing_components.dart';
import '../controller/forecast_landing_controller.dart';
import 'package:http/http.dart' as http;
class ForecastLandingScreen extends StatelessWidget {
  const ForecastLandingScreen({super.key});

  Future<void> getForecast() async{
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };
    http.Response res = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/forecast'));
    print(res.statusCode);
    ConstantLists.forecastGenerated = true;

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      for (var i in data) {
        print(i);
        ForecastModel fm = ForecastModel(typeOfForecast: 'News', dateOfForecast: i[0].toString(), forecastTitle: i[2].toString(),
            forecastDescription: "", forecastImage: i[1],
            forecastDetailImage: i[1],
            realtimeDataModel: RealtimeDataModel(
                usersReached: "382,239",
                totalTweets: "95",
                eventInfluence: "Negative"),
            stockAnalysisAndPredictionList: [StocksAnalysisAndPredictionsModel(
              stockAnalysisImage: Assets.forecastImageTeslaIcon,
              stockAnalysisCompany: "TESLA",
              stockAnalysisCorporateName: "Tesla, Inc.",
              stockAttention: "5.2%",
              stockPolarities: i[4].toString(),
              prediction: "Fall",
            ),
            ]
        );
        ConstantLists.forecastModelList.add(fm);
      }

    }

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


  @override
  Widget build(BuildContext context) {
    final forecastLandingController = Get.find<ForecastLandingController>();
    print(ConstantLists.forecastGenerated);
    return Scaffold(
      appBar: const CustomAppBar(
        needBackButton: false,
        titleText: "Forecast",
        needTitle: true,
        needActions: true,
      ),
      body: Container(
        height: context.height * 1,
        width: context.width * 1,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ConstantLists.forecastGenerated == false ?
        FutureBuilder<void>(
          future: getForecast(), // Call your fetchData function here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ));
            }// Display a loa
            return SingleChildScrollView(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SearchTextField(
                          textEditingController:
                          forecastLandingController.searchTextController,
                          hintText: "Search Here",
                          width: context.width * 1,
                        ),
                      ),
                      5.ph,
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Text(
                              "All Forecasts",
                              style: CustomTextStyles.black620,
                            ),
                            IconButton(onPressed: (){
                              showDialog(context: context, builder: (context) => AlertDialog(
                                title: const Text('Introduction to Forestox Indices'),
                                content: RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: 'User Reached', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' is the estimated number of users who viewed this piece of news.'),
                                          TextSpan(text: "\n"),TextSpan(text: '\n'),
                                          TextSpan(text: 'Total Tweets', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' gives the number of relevant tweets of the stock in the past hour'),
                                          TextSpan(text: '\n'),TextSpan(text: '\n'),
                                          TextSpan(text: 'Event Influence', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' determines the nature of the news and how it might influence the stock'),
                                          TextSpan(text: '\n'),TextSpan(text: '\n'),
                                          TextSpan(text: 'Event Attention', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' is the index used to determine how much attention the event has gained over the past few hours. It is calculated on a thousand base.'),
                                        ]
                                    )
                                ),
                                surfaceTintColor: Colors.white,
                                backgroundColor: Colors.white,
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text('Got it'))
                                ],
                              ));
                            }, icon: const Icon(CupertinoIcons.question_circle_fill))
                          ],
                        ),
                      ),
                      6.5.ph,
                      AnimationLimiter(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ConstantLists.forecastModelList.length,
                          separatorBuilder: (context, index) => 20.ph,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: ForeCastDisplayWidget(
                                    forecastModel:
                                    ConstantLists.forecastModelList[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }) :
        SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SearchTextField(
                      textEditingController:
                      forecastLandingController.searchTextController,
                      hintText: "Search Here",
                      width: context.width * 1,
                    ),
                  ),
                  5.ph,
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        const Text(
                          "All Forecasts",
                          style: CustomTextStyles.black620,
                        ),
                        IconButton(onPressed: (){
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Text('Introduction to Forestox Indices'),
                            content: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'User Reached', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' is the estimated number of users who viewed this piece of news.'),
                                      TextSpan(text: "\n"),TextSpan(text: '\n'),
                                      TextSpan(text: 'Total Tweets', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' gives the number of relevant tweets of the stock in the past hour'),
                                      TextSpan(text: '\n'),TextSpan(text: '\n'),
                                      TextSpan(text: 'Event Influence', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' determines the nature of the news and how it might influence the stock'),
                                      TextSpan(text: '\n'),TextSpan(text: '\n'),
                                      TextSpan(text: 'Event Attention', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' is the index used to determine how much attention the event has gained over the past few hours. It is calculated on a thousand base.'),
                                    ]
                                )
                            ),
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('Got it'))
                            ],
                          ));
                        }, icon: const Icon(CupertinoIcons.question_circle_fill))
                      ],
                    ),
                  ),
                  6.5.ph,
                  AnimationLimiter(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ConstantLists.forecastModelList.length,
                      separatorBuilder: (context, index) => 20.ph,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ForeCastDisplayWidget(
                                forecastModel:
                                ConstantLists.forecastModelList[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

        ),

      bottomNavigationBar: const CustomBottomAppBar(selectedIndex: 1),
    );
  }
}
