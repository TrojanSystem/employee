import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../other/constants.dart';
import '../other/drop_down_menu_button.dart';
import 'add_expense.dart';
import 'daily_expense_item.dart';
import 'daily_expense_pdf_report.dart';
import 'data_storage/expenses_data.dart';

class ExpenseScreen extends StatefulWidget {
  ExpenseScreen({Key key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  int selectedDayOfMonth = DateTime.now().day;

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final yearFilter = Provider.of<ExpensesData>(context).expenseList;
    // final result = yearFilter
    //     .where((element) =>
    //         DateTime.parse(element.itemDate).year == DateTime.now().year)
    //     .toList();
    //
    // var todayMonthFilteredList = result
    //     .where((element) =>
    //         DateTime.parse(element.itemDate).month == DateTime.now().month)
    //     .toList();
    // var dailyExpenses = todayMonthFilteredList
    //     .where((element) =>
    //         DateTime.parse(element.itemDate).day == selectedDayOfMonth)
    //     .toList();
    // var totSell = result
    //     .where((element) =>
    //         DateTime.parse(element.itemDate).month == DateTime.now().month)
    //     .toList();
    // var totalSells = totSell.map((e) => e.itemPrice).toList();
    // var totSum = 0.0;
    // for (int xx = 0; xx < totalSells.length; xx++) {
    //   totSum += double.parse(totalSells[xx]);
    // }
    // var totalDailySells = dailyExpenses.map((e) => e.itemPrice).toList();
    // var totDailySum = 0.0;
    // for (int xx = 0; xx < totalDailySells.length; xx++) {
    //   totDailySum += double.parse(totalDailySells[xx]);
    // }
    // final newLabour = dailyExpenses
    //     .map((e) => DailyExpensePDFReport(
    //           id: e.id.toString(),
    //           price: e.itemPrice,
    //           name: e.itemName,
    //           description: e.itemQuantity,
    //           date: DateFormat.yMMMEd().format(
    //             DateTime.parse(e.itemDate),
    //           ),
    //         ))
    //     .toList();
    // Provider.of<FileHandlerForExpense>(context, listen: false).fileList =
    //     newLabour;
    return Consumer<ExpensesData>(
      builder: (context, dailyExpense, child) => Scaffold(
        //backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          title: const Text(
            'Expenses',
            style: storageTitle,
          ),
          elevation: 0,
        ),
        body: Column(
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
                          items: dailyExpense.daysOfMonth
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
                          children: const [
                            Text(
                              'Daily Expense: ',
                              style: dailyIncomeStyle,
                            ),
                            Text(
                              'Total: ',
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
              child: StreamBuilder<QuerySnapshot>(
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
                    final expense = expenseData.data.docs;

                    final result = expense
                        .where((element) =>
                            DateTime.parse(element['itemDate']).year ==
                            DateTime.now().year)
                        .toList();

                    var todayMonthFilteredList = result
                        .where((element) =>
                            DateTime.parse(element['itemDate']).month ==
                            DateTime.now().month)
                        .toList();
                    var dailyExpense = todayMonthFilteredList
                        .where((element) =>
                            DateTime.parse(element['itemDate']).day ==
                            selectedDayOfMonth)
                        .toList();
                    return dailyExpense.isEmpty
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
                            : ExpenseItem(dailyExpense: dailyExpense);
                  }),
            ),
          ],
        ),
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
            button_2: () {
              setState(() {
                Provider.of<FileHandlerForExpense>(context, listen: false)
                    .createTable();
              });
            },
            button_3: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => MonthProgressExpenseItem(),
              //   ),
              // );
            },
            button_4: () {},
          ),
        ),
      ),
    );
  }
}
