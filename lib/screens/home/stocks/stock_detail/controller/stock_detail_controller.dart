import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDetailController extends GetxController {
  List<Widget> timeSpanTabs = const [
    Tab(
      child: Text("1D"),
    ),
    Tab(
      child: Text("5D"),
    ),
    Tab(
      child: Text("1M"),
    ),
    Tab(
      child: Text("6M"),
    ),
    Tab(
      child: Text("1Y"),
    ),
    Tab(
      child: Text("5Y"),
    ),
    Tab(
      child: Text("MAX"),
    ),
  ];

  toggleSpanTabsList() {}
}
