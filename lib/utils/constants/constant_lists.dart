import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tonyyaooo/models/discussion_model/discussion_model.dart';

import '../../generated/assets.dart';
import '../../models/bottom_navigation_bar_model/bottom_navigation_bar_model.dart';
import '../../models/forecast_model/forecast_model.dart';
import '../../models/notifications_model/notifications_model.dart';
import '../../models/stocks_model/stocks_model.dart';

class ConstantLists {
  ConstantLists._();
  static var loaded = false;

  static List<BottomNavigationBarModel> bottomBarList = [
    BottomNavigationBarModel(
      itemIndex: 0,
      assetString: Assets.bottomAppBarIconsStocksIcon,
      title: "Stocks",
    ),
    BottomNavigationBarModel(
      itemIndex: 1,
      assetString: Assets.bottomAppBarIconsForecastIcon,
      title: "Forecast",
    ),
    BottomNavigationBarModel(
      itemIndex: 2,
      assetString: Assets.bottomAppBarIconsDiscussionIcon,
      title: "Discussion",
    ),
    BottomNavigationBarModel(
      itemIndex: 3,
      assetString: Assets.bottomAppBarIconsNotificationsIcon,
      title: "Notification",
    ),
  ];

  static List<StocksModel> stocksModelList = [
    StocksModel(
        companyImage: Assets.forecastImageTeslaIcon,
        companyName: "AAPL",
        corporateName: "Apple, Inc",
        publicOpinion: "Positive",
        price: "168.22",
        publicAttention: "712.4",
        publicPercentageAttention: "+41.4%",
        predictionPrice: "171.92",
        pricePercentageRaise: "+0.8%",
        predictionPercentagePrice: "+2.2%",
        socialScore: "74.8",
        aiSuggestionAndAnalysis:
        ""
            "1. Diversify Your Portfolio: Don't put all your money into a single stock. Diversification helps spread risk. Consider investing in a mix of different stocks, bonds, and other assets to create a balanced portfolio."
            "\n2. Understand Your Risk Tolerance: Determine how much risk you are comfortable with. Some stocks, like Tesla, can be highly volatile. Make sure your investments align with your risk tolerance and financial goals.",
        priceOverviewData: [
          FlSpot(0, 168.86),
          FlSpot(1, 168.1),
          FlSpot(2, 167.9),
          FlSpot(3, 167.37),
          FlSpot(4, 166.94),
          FlSpot(5, 167.4),
          FlSpot(6, 167),
          FlSpot(7, 167.2),
          FlSpot(8, 167.7),
          FlSpot(9, 168.1),
          FlSpot(10, 167.82),
          FlSpot(11, 167.52),
          FlSpot(12, 167.82),
          FlSpot(13, 167.99),
          FlSpot(14, 168.08),
          FlSpot(15, 167.82),
          FlSpot(16, 167.62),
          FlSpot(17, 167),
          FlSpot(18, 168.02),
          FlSpot(19, 167.9),
          FlSpot(20, 168.22)
        ],
        socialScoreOverviewData: [
          FlSpot(0, 68),
          FlSpot(1, 73),
          FlSpot(2, 89),
          FlSpot(3, 53),
          FlSpot(4, 43),
          FlSpot(5, 55),
          FlSpot(6, 44),
          FlSpot(7, 30),
          FlSpot(8, 35),
          FlSpot(9, 30),
          FlSpot(10, 20),
          FlSpot(11, 10),
          FlSpot(12, 15),
          FlSpot(13, 40),
        ]
    ),
    StocksModel(
      companyImage: Assets.forecastImageTeslaIcon,
      companyName: "TSLA",
      corporateName: "Tesla, Inc",
      publicOpinion: "Negative",
      price: "256.07",
      publicAttention: "523.3",
      publicPercentageAttention: "-22.3%",
      predictionPrice: "225.5",
      pricePercentageRaise: "+1.54",
      predictionPercentagePrice: "-11.9%",
      socialScore: "37.0",
      aiSuggestionAndAnalysis:
          ""
              "1. Diversify Your Portfolio: Don't put all your money into a single stock. Diversification helps spread risk. Consider investing in a mix of different stocks, bonds, and other assets to create a balanced portfolio."
              "\n2. Understand Your Risk Tolerance: Determine how much risk you are comfortable with. Some stocks, like Tesla, can be highly volatile. Make sure your investments align with your risk tolerance and financial goals.",
      priceOverviewData: [
        FlSpot(0, 223.73),
        FlSpot(1, 222.6),
        FlSpot(2, 221.28),
        FlSpot(3, 220.09),
        FlSpot(4, 221.17),
        FlSpot(5, 221.57),
        FlSpot(6, 220.75),
        FlSpot(7, 222.03),
        FlSpot(8, 220),
        FlSpot(9, 218.86),
        FlSpot(10, 217.31),
        FlSpot(11, 218.52),
        FlSpot(12, 220.21),
        FlSpot(13, 216.7),
        FlSpot(14, 215.17),
        FlSpot(15, 211.64),
        FlSpot(16, 212.91),
        FlSpot(17, 212.48),
        FlSpot(18, 212.48),
        FlSpot(19, 215.06),
        FlSpot(20, 213.85)
      ],
      socialScoreOverviewData: [
        FlSpot(0, 68),
        FlSpot(1, 73),
        FlSpot(2, 89),
        FlSpot(3, 53),
        FlSpot(4, 43),
        FlSpot(5, 55),
        FlSpot(6, 44),
        FlSpot(7, 30),
        FlSpot(8, 35),
        FlSpot(9, 30),
        FlSpot(10, 20),
        FlSpot(11, 10),
        FlSpot(12, 15),
        FlSpot(13, 37),
      ]
    ),
    StocksModel(
        companyImage: Assets.forecastImageTeslaIcon,
        companyName: "META",
        corporateName: "Meta, Inc",
        publicOpinion: "Positive",
        price: "308.65",
        publicAttention: "236.6",
        publicPercentageAttention: "-12.3%",
        predictionPrice: "307.09",
        pricePercentageRaise: "-1.33%",
        predictionPercentagePrice: "+1.9%",
        socialScore: "68.3",
        aiSuggestionAndAnalysis:
        ""
            "1. Diversify Your Portfolio: Don't put all your money into a single stock. Diversification helps spread risk. Consider investing in a mix of different stocks, bonds, and other assets to create a balanced portfolio."
            "\n2. Understand Your Risk Tolerance: Determine how much risk you are comfortable with. Some stocks, like Tesla, can be highly volatile. Make sure your investments align with your risk tolerance and financial goals.",
        priceOverviewData: const [
          FlSpot(0, 322.40),
          FlSpot(1, 320.62),
          FlSpot(2, 316.97),
          FlSpot(3, 319.81),
          FlSpot(4, 317.1),
          FlSpot(5, 319.33),
          FlSpot(6, 314.22),
          FlSpot(7, 315.2),
          FlSpot(8, 312.68),
          FlSpot(9, 312.79),
          FlSpot(10, 312.46),
          FlSpot(11, 310.55),
          FlSpot(12, 306.59),
          FlSpot(13, 307.685),
          FlSpot(14, 310),
          FlSpot(15, 309.440),
          FlSpot(16, 311.210),
          FlSpot(17, 312.750),
          FlSpot(18, 310.120),
          FlSpot(19, 308.370),
          FlSpot(20, 308.650)
        ],
        socialScoreOverviewData: const [
          FlSpot(0, 93.2),
          FlSpot(1, 83),
          FlSpot(2, 88.3),
          FlSpot(3, 73.2),
          FlSpot(4, 60),
          FlSpot(5, 55.5),
          FlSpot(6, 49.4),
          FlSpot(7, 78),
          FlSpot(8, 45),
          FlSpot(9, 40),
          FlSpot(10, 37),
          FlSpot(11, 45),
          FlSpot(12, 40),
          FlSpot(13, 37),
        ]
    ),
    StocksModel(
        companyImage: Assets.forecastImageTeslaIcon,
        companyName: "NVDA",
        corporateName: "NVDIA, Corp",
        publicOpinion: "Positive",
        price: "413.87",
        publicAttention: "482.2",
        publicPercentageAttention: "+22.3%",
        predictionPrice: "442.9",
        pricePercentageRaise: "-1.70%",
        predictionPercentagePrice: "-8.97%",
        socialScore: "49.2",
        aiSuggestionAndAnalysis:
        ""
            "1. Diversify Your Portfolio: Don't put all your money into a single stock. Diversification helps spread risk. Consider investing in a mix of different stocks, bonds, and other assets to create a balanced portfolio."
            "\n2. Understand Your Risk Tolerance: Determine how much risk you are comfortable with. Some stocks, like Tesla, can be highly volatile. Make sure your investments align with your risk tolerance and financial goals.",
        priceOverviewData: const [
          FlSpot(0, 461),
          FlSpot(1, 430.12),
          FlSpot(2, 440.68),
          FlSpot(3, 447.27),
          FlSpot(4, 436.89),
          FlSpot(5, 439.55),
          FlSpot(6, 427.29),
          FlSpot(7, 423.71),
          FlSpot(8, 420.21),
          FlSpot(9, 427.42),
          FlSpot(10, 426.62),
          FlSpot(11, 427),
          FlSpot(12, 424.13),
          FlSpot(13, 420.3),
          FlSpot(14, 422.57),
          FlSpot(15, 418.83),
          FlSpot(16, 412.15),
          FlSpot(17, 416.39),
          FlSpot(18, 417.55),
          FlSpot(19, 415.48),
          FlSpot(20, 413.87)
        ],
        socialScoreOverviewData: const [
          FlSpot(0, 30),
          FlSpot(1, 83),
          FlSpot(2, 49.3),
          FlSpot(3, 60.2),
          FlSpot(4, 70),
          FlSpot(5, 80.5),
          FlSpot(6, 67.4),
          FlSpot(7, 78),
          FlSpot(8, 80),
          FlSpot(9, 90),
          FlSpot(10, 70),
          FlSpot(11, 30),
          FlSpot(12, 20),
          FlSpot(13, 37),
        ]
    ),
    StocksModel(
        companyImage: Assets.forecastImageTeslaIcon,
        companyName: "NKE",
        corporateName: "Nike, Inc",
        publicOpinion: "Negative",
        price: "97.98",
        publicAttention: "482.2",
        publicPercentageAttention: "+22.3%",
        predictionPrice: "442.9",
        pricePercentageRaise: "-1.70%",
        predictionPercentagePrice: "-8.97%",
        socialScore: "49.2",
        aiSuggestionAndAnalysis:
        ""
            "1. Diversify Your Portfolio: Don't put all your money into a single stock. Diversification helps spread risk. Consider investing in a mix of different stocks, bonds, and other assets to create a balanced portfolio."
            "\n2. Understand Your Risk Tolerance: Determine how much risk you are comfortable with. Some stocks, like Tesla, can be highly volatile. Make sure your investments align with your risk tolerance and financial goals.",
        priceOverviewData: const [
          FlSpot(0, 223.73),
          FlSpot(1, 222.6),
          FlSpot(2, 221.28),
          FlSpot(3, 220.09),
          FlSpot(4, 221.17),
          FlSpot(5, 221.57),
          FlSpot(6, 220.75),
          FlSpot(7, 222.03),
          FlSpot(8, 220),
          FlSpot(9, 218.86),
          FlSpot(10, 217.31),
          FlSpot(11, 218.52),
          FlSpot(12, 220.21),
          FlSpot(13, 216.7),
          FlSpot(14, 215.17),
          FlSpot(15, 211.64),
          FlSpot(16, 212.91),
          FlSpot(17, 212.48),
          FlSpot(18, 212.48),
          FlSpot(19, 215.06),
          FlSpot(20, 213.85)
        ],
        socialScoreOverviewData: const [
          FlSpot(0, 93.2),
          FlSpot(1, 83),
          FlSpot(2, 88.3),
          FlSpot(3, 73.2),
          FlSpot(4, 60),
          FlSpot(5, 55.5),
          FlSpot(6, 49.4),
          FlSpot(7, 78),
          FlSpot(8, 45),
          FlSpot(9, 40),
          FlSpot(10, 37),
          FlSpot(11, 45),
          FlSpot(12, 40),
          FlSpot(13, 37),
        ]
    )
  ];


  static List<ForecastModel> forecastModelList = [

  ];
  // ForecastModel(
  // typeOfForecast: 'News',
  // dateOfForecast: 'Oct.24th 2023',
  // forecastTitle: "Tesla aware of Autopilot steering malfunction before fatal crash -lawyer",
  // forecastDescription: 'An attorney suing Tesla over a fatal accident cited an internal safety analysis conducted by the company that showed it knew about a steering malfunction in its Autopilot driver assistant feature about two years earlier.',
  // forecastImage: 'assets/images/forecast_image/tesla.jpeg',
  // forecastDetailImage: 'assets/images/forecast_image/tesla.jpeg',
  // realtimeDataModel: RealtimeDataModel(
  // usersReached: "382,239",
  // totalTweets: "94",
  // eventInfluence: "Negative"),
  // stockAnalysisAndPredictionList: [StocksAnalysisAndPredictionsModel(
  // stockAnalysisImage: Assets.forecastImageTeslaIcon,
  // stockAnalysisCompany: "TESLA",
  // stockAnalysisCorporateName: "Tesla, Inc.",
  // stockAttention: "5.2%",
  // stockPolarities: "-70%",
  // prediction: "Fall",
  // )]
  // ),
  // ForecastModel(
  // typeOfForecast: "News",
  // dateOfForecast: "Oct.26 2023",
  // forecastTitle:
  // "Elon Musk vs Mark Zukerberg fight will be streamed on X, according to Musk",
  // forecastDescription:
  // "Lorem ipsum dolor sit amet consectetur. Viverra morbi tempus tristique ut odio est massa iaculis. Neque nibh cursus mi ipsum enim. Pellentesque in in vulputate cras purus lectus ut. Sapien facilisi amet magna facilisi sapien. Nisl rutrum sapien gravida consequat aliquam vitae diam fringilla ipsum. Ornare tellus nullam nunc rhoncus fames. Ut nec nisi ut dictum consequat at posuere in.",
  // forecastImage: Assets.forecastImageForecastModelImage,
  // forecastDetailImage: Assets.forecastImageStockDetailImage,
  // realtimeDataModel: RealtimeDataModel(
  // usersReached: "2,432,201",
  // totalTweets: "5023",
  // eventInfluence: "Positive"),
  // stockAnalysisAndPredictionList: [
  // StocksAnalysisAndPredictionsModel(
  // stockAnalysisImage: Assets.forecastImageTeslaIcon,
  // stockAnalysisCompany: "TSLA",
  // stockAnalysisCorporateName: "Tesla, Inc.",
  // stockAttention: "11.5%",
  // stockPolarities: "+122.5",
  // prediction: "Rise",
  // ),
  // StocksAnalysisAndPredictionsModel(
  // stockAnalysisImage: Assets.forecastImageMetaIcon,
  // stockAnalysisCompany: "Meta",
  // stockAnalysisCorporateName: "Meta, Inc.",
  // stockAttention: "9.8%",
  // stockPolarities: "-0.23",
  // prediction: "Fluctuates",
  // ),
  // ],
  // ),
  // ForecastModel(
  // typeOfForecast: 'News',
  // dateOfForecast: 'Oct.24th 2023',
  // forecastTitle: "PNike execs die after lumber on passing truck strikes them during California bicycle ride",
  // forecastDescription: 'A married couple from Portland — both executives with Nike — died after being hit by lumber that slid off the bed of a passing truck as they rode bicycles in Napa Valley, according to a local report.\nChristian and Michelle Deaton had been biking down the Silverado Trail on the outskirts of Napa at about 11 a.m. Tuesday when a flatbed truck tried to go around them at about 40 mph, according to The Oregonian.\nAt some point, lumber stacked in the bed of the 2018 Freightliner shifted so part of the wood hung over the end of the truck — and it struck the Deatons, the newspaper said.\nChristian, 52, died at the scene. Michelle, 48, died at the hospital, according to the Napa County Sheriff’s Office.',
  // forecastImage: 'assets/images/forecast_image/nikecouple.jpeg',
  // forecastDetailImage: 'assets/images/forecast_image/nikecouple.jpeg',
  // realtimeDataModel: RealtimeDataModel(
  // usersReached: "382,239",
  // totalTweets: "94",
  // eventInfluence: "Negative"),
  // stockAnalysisAndPredictionList: [StocksAnalysisAndPredictionsModel(
  // stockAnalysisImage: 'assets/images/forecast_image/nike.jpeg',
  // stockAnalysisCompany: "NKE",
  // stockAnalysisCorporateName: "Nike, Inc.",
  // stockAttention: "5.2%",
  // stockPolarities: "-12%",
  // prediction: "Fall",
  // )]
  // ),

  // static List<DiscussionModel> discussionModelList = [];

  static List<NotificationModel> notificationModelList = [
    NotificationModel(
      imageAsset: Assets.notificationImagesNitificationImageOne,
      notificationTitle: "Leo Shared a Post",
      notificationDescription: "Click here to view more...",
      notificationTime: "9:13 AM",
    ),
    NotificationModel(
      imageAsset: Assets.notificationImagesNotificationImageTwo,
      notificationTitle: "Tesla Stock Prediction Alert",
      notificationDescription: "View Tesla prediction for 10/27/2023",
      notificationTime: "12:30 PM",
    ),
    NotificationModel(
      imageAsset: Assets.notificationImagesNotificationImageThree,
      notificationTitle: "Meta Stock Prediction",
      notificationDescription: "View Meta prediction for 10/27/2023",
      notificationTime: "12:30 AM",
    ),
    NotificationModel(
      imageAsset: Assets.notificationImagesNotificationImageFour,
      notificationTitle: "Haylie Shared a Post",
      notificationDescription: "Click here to view more...",
      notificationTime: "4:23 PM",
    ),
    NotificationModel(
      imageAsset: "assets/images/app_logo/tonyyaooo_app_logo.png",
      notificationTitle: "Welcome to Forestox",
      notificationDescription: "Take a look around here!",
      notificationTime: "8:00 AM",
    ),
  ];

  static List<Candle> candles = [];

  static bool stocksGenerated = false;
  static bool forecastGenerated = false;

  static Future<void> getStockPrice(String ticker) async {
    print("hello trying to select a chord");
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };

    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse("https://forestox-1.youthinc23.repl.co/stock_price/$ticker")); //post request to URL/analize
    request.headers.addAll(headers);

    await request.send().then((r) async {
      print(r.statusCode);
      if (r.statusCode == 200) {
        r.stream.bytesToString().then((value) {
          List<dynamic> data = jsonDecode(value);
          print(data);
          for (int i=0; i<data.length; i++){
            candles.add(Candle(date: DateTime.fromMicrosecondsSinceEpoch(data[i]["timestamp"]), high: data[i]["high"]+0.0, low: data[i]["low"]+0.0, open: data[i]["open"]+0.0, close: data[i]["close"]+0.0, volume: data[i]["volume"]+0.0));
          }
          print(candles);
        }
        );
      }
    });
  }


  static Future<void> getForecast() async{
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };
    http.Response res = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/forecast'));
    print(res.statusCode);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
    for (var i in data) {
      print(i[4]);
      ForecastModel fm = ForecastModel(typeOfForecast: 'News', dateOfForecast: i[0], forecastTitle: i[2],
        forecastDescription: i[4], forecastImage: i[1],
        forecastDetailImage: i[1],
        realtimeDataModel: RealtimeDataModel(
          usersReached: "382,239",
          totalTweets: "94",
          eventInfluence: i[3].toString()),
      stockAnalysisAndPredictionList: [StocksAnalysisAndPredictionsModel(
            stockAnalysisImage: Assets.forecastImageTeslaIcon,
                stockAnalysisCompany: "TESLA",
                stockAnalysisCorporateName: "Tesla, Inc.",
                stockAttention: "5.2%",
                stockPolarities: i[3].toString(),
                prediction: "Fall",
            ),
      ]
      );

      forecastModelList.add(fm);
    }

    }
  }



  String test = "";
  static Future<void> getPrediction(ticker) async {
    print("hello trying to select a chord");
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };
    http.Response res = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/predict/$ticker'));
    print(res.statusCode);

    if (res.statusCode == 200) {

          stocksModelList[0].predictionPrice = res.body.toString().substring(0,6);

      }
  }//SELECT CHORD OLD ALGORITHM

  static Future<void> getTweetNum(ticker) async {
    print("hello trying to select a chord");
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };
    http.Response res = await http.get(Uri.parse('https://forestox-1.youthinc23.repl.co/tweet_info/$ticker'));
    print(res.statusCode);

    if (res.statusCode == 200) {
      ConstantLists.stocksModelList[0].publicAttention = json.decode(res.body)[0]["total_tweets"];
    }
  }
}
