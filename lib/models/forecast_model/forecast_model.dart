class ForecastModel {
  String typeOfForecast,
      dateOfForecast,
      forecastTitle,
      forecastDescription,
      forecastImage,
      forecastDetailImage;
  RealtimeDataModel realtimeDataModel;
  List<StocksAnalysisAndPredictionsModel> stockAnalysisAndPredictionList;

  ForecastModel({
    required this.typeOfForecast,
    required this.dateOfForecast,
    required this.forecastTitle,
    required this.forecastDescription,
    required this.forecastImage,
    required this.forecastDetailImage,
    required this.realtimeDataModel,
    required this.stockAnalysisAndPredictionList,
  });
}

class RealtimeDataModel {
  String usersReached, totalTweets, eventInfluence;

  RealtimeDataModel({
    required this.usersReached,
    required this.totalTweets,
    required this.eventInfluence,
  });
}

class StocksAnalysisAndPredictionsModel {
  String stockAnalysisImage,
      stockAnalysisCompany,
      stockAnalysisCorporateName,
      stockAttention,
      stockPolarities,
      prediction;

  StocksAnalysisAndPredictionsModel({
    required this.stockAnalysisImage,
    required this.stockAnalysisCompany,
    required this.stockAnalysisCorporateName,
    required this.stockAttention,
    required this.stockPolarities,
    required this.prediction,
  });
}
