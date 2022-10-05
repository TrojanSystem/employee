import 'package:ada_bread/data_provider.dart';
import 'package:ada_bread/data_storage.dart';
import 'package:ada_bread/home_screen/production_input.dart';
import 'package:ada_bread/home_screen/shop_analysis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../other/constants.dart';
import '../other/drop_down_menu_button.dart';

class DailySell extends StatefulWidget {
  const DailySell({Key key}) : super(key: key);

  @override
  State<DailySell> createState() => _DailySellState();
}

class _DailySellState extends State<DailySell> {
  List dailySold = [];
  bool isTapped = true;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;
  int selectedDayOfMonth = DateTime.now().day;
  int totIncome = 0;
  int totExpectedIncome = 0;
  List result = [];
  @override
  void initState() {
    dailySold;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageOfBread = [
      'images/bale_5.png',
      'images/bale_10.png',
      'images/slice.png',
      'images/donut.png'
    ];
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    //final dailyGiven = Provider.of<DataProvider>(context).databaseDataForProduction;
    final dailyExpense = Provider.of<DataStorage>(context).daysOfMonth;
    dailySold = Provider.of<DataProvider>(context).databaseDataForProduction;
    // print(dailySold);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Ada Bread',
          style: storageTitle,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
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
                        items: dailyExpense
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
                            'Expected Income: $totExpectedIncome',
                            style: dailyIncomeStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Tot Sold: $totIncome',
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
            flex: 6,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('DailyShopSell')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 3,
                    ),
                  );
                }
                final productionData = snapshot.data.docs;
                result = productionData
                    .where((element) =>
                        DateTime.parse(element['date']).year ==
                        DateTime.now().year)
                    .toList();

                var todayMonthFilteredList = result
                    .where((element) =>
                        DateTime.parse(element['date']).month ==
                        DateTime.now().month)
                    .toList();
                var dataEntered = todayMonthFilteredList
                    .where((element) =>
                        DateTime.parse(element['date']).day ==
                        selectedDayOfMonth)
                    .toList();

                totIncome = dataEntered.isEmpty
                    ? 0
                    : ((int.parse(dataEntered.last['bale_5']) *
                            int.parse(dataEntered.last['bale_5_Sp'])) +
                        (int.parse(dataEntered.last['bale_10']) *
                            int.parse(dataEntered.last['bale_10_Sp'])) +
                        (int.parse(dataEntered.last['slice']) *
                            int.parse(dataEntered.last['slice_Sp'])) +
                        (int.parse(dataEntered.last['bombolino']) *
                            int.parse(dataEntered.last['bombolino_Sp'])));
                totExpectedIncome = dailySold.isEmpty
                    ? 0
                    : ((int.parse(dailySold.last['bale_5']) *
                            int.parse(dailySold.last['bale_5_Sp'])) +
                        (int.parse(dailySold.last['bale_10']) *
                            int.parse(dailySold.last['bale_10_Sp'])) +
                        (int.parse(dailySold.last['slice']) *
                            int.parse(dailySold.last['slice_Sp'])) +
                        (int.parse(dailySold.last['bombolino']) *
                            int.parse(dailySold.last['bombolino_Sp'])));

                return dataEntered.isEmpty
                    ? Center(
                        child: Image.asset(
                          'images/no_order.png',
                          width: 200,
                        ),
                      )
                    : snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: 3,
                            ),
                          )
                        : ListView.builder(
                            itemCount: dataEntered.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedContainer(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  margin: const EdgeInsets.only(
                                      left: 8.0, right: 8, top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromRGBO(40, 53, 147, 1),
                                        const Color.fromRGBO(40, 53, 147, 1)
                                            .withOpacity(0.9)
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 4,
                                        offset: const Offset(
                                            4, 8), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  height: 350,
                                  width: 350,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat.E().format(
                                              DateTime.parse(
                                                  dailySold.last['date']),
                                            ),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text('Tot Daily Income: $totIncome',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                              )),
                                        ],
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: AnimationLimiter(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          AnimationConfiguration
                                                              .staggeredGrid(
                                                        position: 0,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        columnCount:
                                                            columnCount,
                                                        child: ScaleAnimation(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      900),
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          child:
                                                              FadeInAnimation(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          _w /
                                                                              30,
                                                                      left: _w /
                                                                          60,
                                                                      right: _w /
                                                                          60),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.1),
                                                                    blurRadius:
                                                                        40,
                                                                    spreadRadius:
                                                                        10,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Image.asset(
                                                                    imageOfBread[
                                                                        0],
                                                                    width: 50,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Given',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dailySold.length <
                                                                                dataEntered.length
                                                                            ? dailySold.last['bale_5'].toString()
                                                                            : dailySold[index]['bale_5'].toString()),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Sold',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dataEntered[index]['bale_5']
                                                                            .toString()),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          AnimationConfiguration
                                                              .staggeredGrid(
                                                        position: 1,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        columnCount:
                                                            columnCount,
                                                        child: ScaleAnimation(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      900),
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          child:
                                                              FadeInAnimation(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          _w /
                                                                              30,
                                                                      left: _w /
                                                                          60,
                                                                      right: _w /
                                                                          60),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.1),
                                                                    blurRadius:
                                                                        40,
                                                                    spreadRadius:
                                                                        10,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Image.asset(
                                                                    imageOfBread[
                                                                        1],
                                                                    width: 50,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Given',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dailySold.length <
                                                                                dataEntered.length
                                                                            ? dailySold.last['bale_10'].toString()
                                                                            : dailySold[index]['bale_10'].toString()),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Sold',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dataEntered[index]['bale_10']
                                                                            .toString()),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          AnimationConfiguration
                                                              .staggeredGrid(
                                                        position: 0,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        columnCount:
                                                            columnCount,
                                                        child: ScaleAnimation(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      900),
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          child:
                                                              FadeInAnimation(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          _w /
                                                                              30,
                                                                      left: _w /
                                                                          60,
                                                                      right: _w /
                                                                          60),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.1),
                                                                    blurRadius:
                                                                        40,
                                                                    spreadRadius:
                                                                        10,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Image.asset(
                                                                    imageOfBread[
                                                                        2],
                                                                    width: 50,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Given',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dailySold.length <
                                                                                dataEntered.length
                                                                            ? dailySold.last['slice'].toString()
                                                                            : dailySold[index]['slice'].toString()),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Sold',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dataEntered[index]['slice']
                                                                            .toString()),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          AnimationConfiguration
                                                              .staggeredGrid(
                                                        position: 0,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        columnCount:
                                                            columnCount,
                                                        child: ScaleAnimation(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      900),
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          child:
                                                              FadeInAnimation(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          _w /
                                                                              30,
                                                                      left: _w /
                                                                          60,
                                                                      right: _w /
                                                                          60),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.1),
                                                                    blurRadius:
                                                                        40,
                                                                    spreadRadius:
                                                                        10,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Image.asset(
                                                                    imageOfBread[
                                                                        3],
                                                                    width: 50,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Given',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dailySold.length <
                                                                                dataEntered.length
                                                                            ? dailySold.last['bombolino'].toString()
                                                                            : dailySold[index]['bombolino'].toString()),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Sold',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w900),
                                                                        ),
                                                                        Text(dataEntered[index]['bombolino']
                                                                            .toString()),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButton(
            primaryColor: Colors.red,
            button_1: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ProductionInput(),
                ),
              );
            },
            button_2: () {},
            button_3: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ShopAnalysis(monthlyOrder: result),
                ),
              );
            },
            button_4: () {}),
      ),
    );
  }
}
