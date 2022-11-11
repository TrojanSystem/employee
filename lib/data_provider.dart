import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot<Object>> expenseList = [];
  List<QueryDocumentSnapshot<Object>> databaseDataForShop = [];
  String loggedUserEmail = '';
  String loggedUseUniqueID = '';
  String loggedUserName = '';
  String totalSoldIncome = '';
  String totalExpectedIncome = '';
  String totalAppbarSoldIncome = '';
  String totalAppbarExpectedIncome = '';

  final List<Map<String, dynamic>> dailyShopData = [];
  final List<Map<String, dynamic>> loggedUserList = [];
  checker(String userEmail, userName) {
    loggedUserEmail = userEmail;
    loggedUserName = userName;
    notifyListeners();
  }

  uniqueID(String ID) {
    loggedUseUniqueID = ID;
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

  // void loadExpenseList() async {
  //   notifyListeners();
  //   await for (var y in FirebaseFirestore.instance
  //       .collection('EmployeeExpenses')
  //       .snapshots()) {
  //     for (var snapSell in y.docs) {
  //       notifyListeners();
  //       expenseList.add(snapSell.data());
  //     }
  //   }
  //   notifyListeners();
  // }

  void loadLoggedUser() async {
    notifyListeners();
    await for (var y
        in FirebaseFirestore.instance.collection('LoggedUser').snapshots()) {
      for (var snapSell in y.docs) {
        notifyListeners();
        loggedUserList.add(snapSell.data());
      }
    }
    notifyListeners();
  }

  List daysOfMonth = [
    {
      'mon': 'Day 1',
      'day': 1,
    },
    {
      'mon': 'Day 2',
      'day': 2,
    },
    {
      'mon': 'Day 3',
      'day': 3,
    },
    {
      'mon': 'Day 4',
      'day': 4,
    },
    {
      'mon': 'Day 5',
      'day': 5,
    },
    {
      'mon': 'Day 6',
      'day': 6,
    },
    {
      'mon': 'Day 7',
      'day': 7,
    },
    {
      'mon': 'Day 8',
      'day': 8,
    },
    {
      'mon': 'Day 9',
      'day': 9,
    },
    {
      'mon': 'Day 10',
      'day': 10,
    },
    {
      'mon': 'Day 11',
      'day': 11,
    },
    {
      'mon': 'Day 12',
      'day': 12,
    },
    {
      'mon': 'Day 13',
      'day': 13,
    },
    {
      'mon': 'Day 14',
      'day': 14,
    },
    {
      'mon': 'Day 15',
      'day': 15,
    },
    {
      'mon': 'Day 16',
      'day': 16,
    },
    {
      'mon': 'Day 17',
      'day': 17,
    },
    {
      'mon': 'Day 18',
      'day': 18,
    },
    {
      'mon': 'Day 19',
      'day': 19,
    },
    {
      'mon': 'Day 20',
      'day': 20,
    },
    {
      'mon': 'Day 21',
      'day': 21,
    },
    {
      'mon': 'Day 22',
      'day': 22,
    },
    {
      'mon': 'Day 23',
      'day': 23,
    },
    {
      'mon': 'Day 24',
      'day': 24,
    },
    {
      'mon': 'Day 25',
      'day': 25,
    },
    {
      'mon': 'Day 26',
      'day': 26,
    },
    {
      'mon': 'Day 27',
      'day': 27,
    },
    {
      'mon': 'Day 28',
      'day': 28,
    },
    {
      'mon': 'Day 29',
      'day': 29,
    },
    {
      'mon': 'Day 30',
      'day': 30,
    },
    {
      'mon': 'Day 31',
      'day': 31,
    },
  ];
  List monthOfAYear = [
    {
      'mon': 'Jan',
      'day': 1,
    },
    {
      'mon': 'Feb',
      'day': 2,
    },
    {
      'mon': 'Mar',
      'day': 3,
    },
    {
      'mon': 'Apr',
      'day': 4,
    },
    {
      'mon': 'May',
      'day': 5,
    },
    {
      'mon': 'Jun',
      'day': 6,
    },
    {
      'mon': 'Jul',
      'day': 7,
    },
    {
      'mon': 'Aug',
      'day': 8,
    },
    {
      'mon': 'Sept',
      'day': 9,
    },
    {
      'mon': 'Oct',
      'day': 10,
    },
    {
      'mon': 'Nov',
      'day': 11,
    },
    {
      'mon': 'Dec',
      'day': 12,
    },
  ];
}
