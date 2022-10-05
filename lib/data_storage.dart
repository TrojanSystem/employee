import 'dart:core';

import 'package:flutter/cupertino.dart';

class DataStorage extends ChangeNotifier {
  int index = 0;
  int currentYear = 0;
  // List<ContractModel> contactList = [];
  // List<DailyProductionModel> productionList = [];
  void currentIndex(currentIndex) {
    index = currentIndex;
    notifyListeners();
  }

  //
  // void contractList(name, quantity, date, price) {
  //   contactList.add(
  //     ContractModel(
  //       name: name,
  //       date: date,
  //       quantity: quantity,
  //       price: price,
  //     ),
  //   );
  //   notifyListeners();
  // }
  //
  // void dailyProductionList(bale_5, bale_10, slice, bombolino) {
  //   productionList.add(
  //     DailyProductionModel(
  //       bale_5: bale_5,
  //       bale_10: bale_10,
  //       slice: slice,
  //       bombolino: bombolino,
  //     ),
  //   );
  //   notifyListeners();
  // }
  //
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
      'month': 'Jan',
      'days': 1,
    },
    {
      'month': 'Feb',
      'days': 2,
    },
    {
      'month': 'Mar',
      'days': 3,
    },
    {
      'month': 'Apr',
      'days': 4,
    },
    {
      'month': 'May',
      'days': 5,
    },
    {
      'month': 'Jun',
      'days': 6,
    },
    {
      'month': 'Jul',
      'days': 7,
    },
    {
      'month': 'Aug',
      'days': 8,
    },
    {
      'month': 'Sept',
      'days': 9,
    },
    {
      'month': 'Oct',
      'days': 10,
    },
    {
      'month': 'Nov',
      'days': 11,
    },
    {
      'month': 'Dec',
      'days': 12,
    },
  ];
}
