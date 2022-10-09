import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String loggedUserEmail = '';
  String totalSoldIncome = '';
  String totalExpectedIncome = '';
  String totalAppbarSoldIncome = '';
  String totalAppbarExpectedIncome = '';

  final List<Map<String, dynamic>> dailyShopData = [];

  checker(String userEmail) {
    loggedUserEmail = userEmail;

    notifyListeners();
  }

  totalIncome(String sold, String expected) {
    totalAppbarSoldIncome = sold;
    totalAppbarExpectedIncome = expected;
    //notifyListeners();
  }

  binders(String totalSold, String expectedIncome) {
    totalSoldIncome = totalSold;
    totalExpectedIncome = expectedIncome;
    //notifyListeners();
  }

  void loadSoldList() async {
    notifyListeners();
    await for (var y
        in FirebaseFirestore.instance.collection('DailyShopSell').snapshots()) {
      for (var snapSell in y.docs) {
        // notifyListeners();
        dailyShopData.add(snapSell.data());
      }
    }
    notifyListeners();
  }
}
