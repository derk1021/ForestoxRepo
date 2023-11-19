import 'package:fl_chart/fl_chart.dart';

class StocksModel {
  String companyImage,
      companyName,
      corporateName,
      publicOpinion,
      price,
      publicAttention,
      publicPercentageAttention,
      predictionPrice,
      pricePercentageRaise,
      predictionPercentagePrice,
      socialScore,
      aiSuggestionAndAnalysis;
  List<FlSpot> priceOverviewData, socialScoreOverviewData;

  StocksModel({
    required this.companyImage,
    required this.companyName,
    required this.corporateName,
    required this.publicOpinion,
    required this.price,
    required this.publicAttention,
    required this.publicPercentageAttention,
    required this.predictionPrice,
    required this.pricePercentageRaise,
    required this.predictionPercentagePrice,
    required this.socialScore,
    required this.aiSuggestionAndAnalysis,
    required this.priceOverviewData,
    required this.socialScoreOverviewData
  });
}
