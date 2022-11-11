import 'package:ada_bread/data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../other/constants.dart';
import '../other/drop_down_menu_button.dart';
import 'add_expense.dart';
import 'daily_expense_item.dart';
import 'month_progress_expense_item.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  int selectedDayOfMonth = DateTime.now().day;

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final day = Provider.of<DataProvider>(context, listen: false).daysOfMonth;
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Expenses',
          style: storageTitle,
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('EmployeeExpenses')
              .snapshots(),
          builder: (context, expenseData) {
            if (!expenseData.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              );
            }
            final expenseForExpenseScreen = expenseData.data.docs;

            final yearlyExpenseFilterForExpenseScreen = expenseForExpenseScreen
                .where((element) =>
                    DateTime.parse(element['itemDate']).year ==
                    DateTime.now().year)
                .toList();
            var dailyExpenseType = yearlyExpenseFilterForExpenseScreen
                .where((element) => element['expenseType'] == 'employee')
                .toList();
            var monthlyExpenseFilterForExpenseScreen = dailyExpenseType
                .where((element) =>
                    DateTime.parse(element['itemDate']).month ==
                    DateTime.now().month)
                .toList();
            var dailyExpenseFilterForExpenseScreen =
                monthlyExpenseFilterForExpenseScreen
                    .where((element) =>
                        DateTime.parse(element['itemDate']).day ==
                        selectedDayOfMonth)
                    .toList();
            var listOfYearlyExpenseItemPrice =
                yearlyExpenseFilterForExpenseScreen
                    .map((e) => e['itemPrice'])
                    .toList();
            var listOfYearlyExpenseItemQuantity =
                yearlyExpenseFilterForExpenseScreen
                    .map((e) => e['itemQuantity'])
                    .toList();
            var totalYearlyExpenseSum = 0.0;
            for (int xx = 0; xx < listOfYearlyExpenseItemPrice.length; xx++) {
              totalYearlyExpenseSum +=
                  (double.parse(listOfYearlyExpenseItemPrice[xx]) *
                      double.parse(listOfYearlyExpenseItemQuantity[xx]));
            }
            var listOfMonthlyExpenseItemPrice =
                dailyExpenseFilterForExpenseScreen
                    .map((e) => e['itemPrice'])
                    .toList();
            var listOfMonthlyExpenseItemQuantity =
                dailyExpenseFilterForExpenseScreen
                    .map((e) => e['itemQuantity'])
                    .toList();
            var totalMonthlyExpenseSum = 0.0;
            for (int xx = 0; xx < listOfMonthlyExpenseItemPrice.length; xx++) {
              totalMonthlyExpenseSum +=
                  (double.parse(listOfMonthlyExpenseItemPrice[xx]) *
                      double.parse(listOfMonthlyExpenseItemQuantity[xx]));
            }

            Provider.of<DataProvider>(context, listen: false).expenseList =
                yearlyExpenseFilterForExpenseScreen;
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              dropdownColor: Colors.grey[850],
                              iconEnabledColor: Colors.white,
                              menuMaxHeight: 300,
                              value: selectedDayOfMonth,
                              items: day
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(
                                        e['mon'],
                                        style: kkDropDown,
                                      ),
                                      value: e['day'],
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDayOfMonth = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daily Expense: $totalMonthlyExpenseSum ',
                                  style: dailyIncomeStyle,
                                ),
                                Text(
                                  'Total Expense: $totalYearlyExpenseSum',
                                  style: dailyIncomeStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    color: const Color.fromRGBO(3, 83, 151, 1),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: dailyExpenseFilterForExpenseScreen.isEmpty
                      ? Image.asset(
                          'images/empty.png',
                          width: 300,
                        )
                      : expenseData.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                          : ExpenseItem(
                              dailyExpense: dailyExpenseFilterForExpenseScreen),
                ),
              ],
            );
          }),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButton(
          primaryColor: Colors.red[800],
          button_1: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddExpense(),
              ),
            );
          },
          button_3: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const MonthProgressExpenseItem(),
              ),
            );
          },
        ),
      ),
    );
  }
}
