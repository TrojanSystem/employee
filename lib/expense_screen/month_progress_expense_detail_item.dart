import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class MonthProgressExpenseDetailItem extends StatelessWidget {
  final List todayFilteredList;
  final int index;

  MonthProgressExpenseDetailItem({this.todayFilteredList, this.index});

  @override
  Widget build(BuildContext context) {
    var filteredName =
        todayFilteredList.map((e) => e.itemName).toSet().toList();
    filteredName.sort();
    var x = todayFilteredList
        .where((e) => e.itemName.toString() == filteredName[index])
        .toList();

    var totalSells = todayFilteredList.map((e) => e.itemPrice).toList();

    double totSum = 0.0;
    for (int xx = 0; xx < totalSells.length; xx++) {
      totSum += (double.parse(totalSells[xx]));
    }
    var z = x.map((e) => e.itemName).toList();
    var zz = x.map((e) => e.itemPrice).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(zz[x]);
    }
    double expensePercentage = ((sum * 100) / totSum);

    return SizedBox(
      width: double.infinity,
      //color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18.0, bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      filteredName[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      height: 25,
                      width: 250,
                      child: FAProgressBar(
                        backgroundColor: Colors.black12,
                        size: 20,
                        progressColor: Colors.red,
                        currentValue: totSum == 0
                            ? 0
                            : double.parse(
                                expensePercentage.toStringAsFixed(2)),
                        displayText: '%',
                        displayTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
