import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:tonyyaooo/reusable_widgets/app_bar/custom_appbar.dart';
import 'package:tonyyaooo/reusable_widgets/bottom_nav_bar/reusable_bottom_navbar.dart';
import 'package:tonyyaooo/screens/home/stocks/stock_detail/view/stock_detail_screen.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';

import '../../../../../reusable_widgets/text_field/search_text_field.dart';
import '../../../../../utils/constants/constant_lists.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../component/stocks_landing_component.dart';
import '../controller/stocks_landing_controller.dart';

class StocksLandingScreen extends StatelessWidget {
  const StocksLandingScreen({super.key});


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
    final stocksLandingController = Get.find<StocksLandingController>();
    // ConstantLists.getTweetNum("TSLA");
    return Scaffold(
      appBar: const CustomAppBar(
        needBackButton: false,
        titleText: "Stocks",
        needTitle: true,
        needActions: true,
      ),
      body: Container(
        height: context.height * 1,
        width: context.width * 1,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SearchTextField(
                      textEditingController:
                      stocksLandingController.searchTextController,
                      hintText: "Search Here",
                      width: context.width * 1,
                      onChangedFunction: (String newString){
                        if (newString=='tsla'){
                          Get.off(
                                () => StockDetailScreen(ConstantLists.stocksModelList[1]),
                            transition: Transition.fadeIn,
                          );
                        }
                      },
                    ),
                  ),
                  5.ph,
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        const Text(
                          "All Stocks",
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
                                      TextSpan(text: 'Public Attention', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' is the index used to determine how much attention the stock has gained over the past few hours. It is calculated on a thousand base.'),
                                      TextSpan(text: "\n"),TextSpan(text: '\n'),
                                      TextSpan(text: 'Social Score', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' is a quantitative index that indicates the public opinions of a stock.'),
                                      TextSpan(text: '\n'),TextSpan(text: '\n'),
                                      TextSpan(text: 'Prediction Price', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' is the predicated price of the stock based on our social-oriented model'),
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
                  ConstantLists.stocksGenerated == false ?
                  FutureBuilder<List<http.Response>>(
                      future: fetchStock(), // Call your fetchData function here
                      builder: (context, snapshot) {
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
                        }
                        else {
                          ConstantLists.stocksModelList[0].price = json.decode(snapshot.data![0].body)[0]["Close"].toString().substring(0,6);
                          return AnimationLimiter(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ConstantLists.stocksModelList.length,
                              separatorBuilder: (context, index) => 20.ph,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: StocksLandingWidget(
                                        stocksModel:
                                        ConstantLists.stocksModelList[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }) :
                  AnimationLimiter(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ConstantLists.stocksModelList.length,
                      separatorBuilder: (context, index) => 20.ph,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: StocksLandingWidget(
                                stocksModel:
                                ConstantLists.stocksModelList[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(selectedIndex: 0),
    );
  }
}
