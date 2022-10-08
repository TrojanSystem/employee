import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String loggedUserEmail = '';
  final List<Map<String, dynamic>> databaseDataForProduction = [];
  final List<Map<String, dynamic>> databaseDataForShop = [];

  checker(String userEmail) {
    loggedUserEmail = userEmail;
    notifyListeners();
  }

  void loadProductionList() async {
    notifyListeners();
    await for (var x
        in FirebaseFirestore.instance.collection('DailySell').snapshots()) {
      for (var snap in x.docs) {
        notifyListeners();
        databaseDataForProduction.add(snap.data());
      }
    }
    notifyListeners();
  }

  void loadShopGivenList() async {
    notifyListeners();
    await for (var x in FirebaseFirestore.instance
        .collection('DailyShopGiven')
        .snapshots()) {
      for (var snap in x.docs) {
        notifyListeners();
        databaseDataForProduction.add(snap.data());
      }
    }
    notifyListeners();
  }

  void loadSoldList() async {
    notifyListeners();
    await for (var y
        in FirebaseFirestore.instance.collection('DailyShopSell').snapshots()) {
      for (var snapSell in y.docs) {
        notifyListeners();
        databaseDataForShop.add(snapSell.data());
      }
    }
    notifyListeners();
  }
}
