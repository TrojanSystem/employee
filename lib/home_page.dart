import 'package:ada_bread/expense_screen/expense_screen.dart';
import 'package:ada_bread/home_screen/daily_sell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_storage.dart';
import 'order_screen/order_screen.dart';
import 'other/bottom_nav_item.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final List screens = [
    const DailySell(),
    OrderScreen(),
    ExpenseScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<DataStorage>(context).index;

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: MyCustomBottomNavigationBar(),
    );
  }
}
