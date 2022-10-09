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

List result = [];
List whoLogged = [];

class DailySell extends StatefulWidget {
  const DailySell({Key key}) : super(key: key);

  @override
  State<DailySell> createState() => _DailySellState();
}

class _DailySellState extends State<DailySell> {
  List productionData = [];
  List dailySold = [];

  var data;
  int updateIndex = 0;
  bool isTapped = true;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;
  int selectedDayOfMonth = DateTime.now().day;
  int totIncome = 0;
  int totExpectedIncome = 0;

  @override
  void initState() {
    data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    final dailyGiven = Provider.of<DataProvider>(context).loggedUserEmail;
    data = Provider.of<DataProvider>(context);
    final dailyExpense = Provider.of<DataStorage>(context).daysOfMonth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Ada Bread',
          style: storageTitle,
        ),
        centerTitle: true,
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
                            'Expected Income: ${data.totalExpectedIncome}',
                            style: dailyIncomeStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Tot Sold: ${data.totalSoldIncome}',
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
                  .collection('DailyShopGiven')
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
                productionData = snapshot.data.docs;
                whoLogged = productionData
                    .where((element) => element['seller'] == dailyGiven)
                    .toList();

                result = whoLogged
                    .where((element) =>
                        DateTime.parse(element['producedDate']).year ==
                        DateTime.now().year)
                    .toList();

                var daboMonthlyDelivered = result
                    .where((element) =>
                        DateTime.parse(element['producedDate']).month ==
                        DateTime.now().month)
                    .toList();
                var dataEntered = daboMonthlyDelivered
                    .where((element) =>
                        DateTime.parse(element['producedDate']).day ==
                        selectedDayOfMonth)
                    .toList();

                var totalDailyGivenItemsBale_5 =
                    dataEntered.map((e) => e['bale_5']).toList();

                var totDailyGivenSumBale_5 = 0;
                for (int xx = 0; xx < totalDailyGivenItemsBale_5.length; xx++) {
                  totDailyGivenSumBale_5 +=
                      int.parse(totalDailyGivenItemsBale_5[xx]);
                }
                var totalDailyGivenItemsBale_10 =
                    dataEntered.map((e) => e['bale_10']).toList();

                var totDailyGivenSumBale_10 = 0;
                for (int xx = 0;
                    xx < totalDailyGivenItemsBale_10.length;
                    xx++) {
                  totDailyGivenSumBale_10 +=
                      int.parse(totalDailyGivenItemsBale_10[xx]);
                }
                var totalDailyGivenItemsSlice =
                    dataEntered.map((e) => e['slice']).toList();

                var totDailyGivenSumSlice = 0;
                for (int xx = 0; xx < totalDailyGivenItemsSlice.length; xx++) {
                  totDailyGivenSumSlice +=
                      int.parse(totalDailyGivenItemsSlice[xx]);
                }
                var totalDailyGivenItemsBombolino =
                    dataEntered.map((e) => e['bombolino']).toList();

                var totDailyGivenSumBombolino = 0;
                for (int xx = 0;
                    xx < totalDailyGivenItemsBombolino.length;
                    xx++) {
                  totDailyGivenSumBombolino +=
                      int.parse(totalDailyGivenItemsBombolino[xx]);
                }
                final double totalGivenBale_5 = totDailyGivenSumBale_5 *
                    (dataEntered.isEmpty
                        ? 0.0
                        : double.parse(dataEntered.last['bale_5_Sp']));
                final double totalGivenBale_10 = totDailyGivenSumBale_10 *
                    (dataEntered.isEmpty
                        ? 0.0
                        : double.parse(dataEntered.last['bale_10_Sp']));
                final double totalGivenSlice = totDailyGivenSumSlice *
                    (dataEntered.isEmpty
                        ? 0.0
                        : double.parse(dataEntered.last['slice_Sp']));
                final double totalGivenBombolino = totDailyGivenSumBombolino *
                    (dataEntered.isEmpty
                        ? 0.0
                        : double.parse(dataEntered.last['bombolino_Sp']));
                double totalSumOfShopGiven = totalGivenBale_5 +
                    totalGivenBale_10 +
                    totalGivenSlice +
                    totalGivenBombolino;

/*
*
*
*
*
*
*
*
*
*
* */

                final shopDailySold =
                    Provider.of<DataProvider>(context).dailyShopData;
                var currentLoggedIn = shopDailySold
                    .where((element) => element['employeeEmail'] == dailyGiven)
                    .toList();

                final resultShopSold = currentLoggedIn
                    .where((element) =>
                        DateTime.parse(element['date']).year ==
                        DateTime.now().year)
                    .toList()
                    .toSet();

                var currentLoggedInFilteredList = resultShopSold
                    .where((element) =>
                        DateTime.parse(element['date']).month ==
                        DateTime.now().month)
                    .toList();
                var dailySoldItems = currentLoggedInFilteredList
                    .where((element) =>
                        DateTime.parse(element['date']).day ==
                        selectedDayOfMonth)
                    .toList();

                var totalDailySoldItemsBale_5 =
                    dailySoldItems.map((e) => e['bale_5']).toList();
                print('this ${totalDailySoldItemsBale_5}');
                var totDailySoldSumBale_5 = 0;
                for (int xx = 0; xx < totalDailySoldItemsBale_5.length; xx++) {
                  totDailySoldSumBale_5 +=
                      int.parse(totalDailySoldItemsBale_5[xx]);
                }
                var totalDailySoldItemsBale_10 =
                    dailySoldItems.map((e) => e['bale_10']).toList();

                var totDailySoldSumBale_10 = 0;
                for (int xx = 0; xx < totalDailySoldItemsBale_10.length; xx++) {
                  totDailySoldSumBale_10 +=
                      int.parse(totalDailySoldItemsBale_10[xx]);
                }
                var totalDailySoldItemsSlice =
                    dailySoldItems.map((e) => e['slice']).toList();

                var totDailySoldSumSlice = 0;
                for (int xx = 0; xx < totalDailySoldItemsSlice.length; xx++) {
                  totDailySoldSumSlice +=
                      int.parse(totalDailySoldItemsSlice[xx]);
                }
                var totalDailySoldItemsBombolino =
                    dailySoldItems.map((e) => e['bombolino']).toList();

                var totDailySoldSumBombolino = 0;
                for (int xx = 0;
                    xx < totalDailySoldItemsBombolino.length;
                    xx++) {
                  totDailySoldSumBombolino +=
                      int.parse(totalDailySoldItemsBombolino[xx]);
                }
                final double totalBale_5 = totDailySoldSumBale_5 *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['bale_5_Sp']));
                final double totalBale_10 = totDailySoldSumBale_10 *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['bale_10_Sp']));
                final double totalSlice = totDailySoldSumSlice *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['slice_Sp']));
                final double totalBombolino = totDailySoldSumBombolino *
                    (dailySoldItems.isEmpty
                        ? 0.0
                        : double.parse(dailySoldItems.last['bombolino_Sp']));
                double totalSumOfShop =
                    totalBale_5 + totalBale_10 + totalSlice + totalBombolino;
                final listOfPrice = [
                  {
                    'image': 'images/bale_5.png',
                    'sold': '$totDailySoldSumBale_5',
                    'given': '$totDailyGivenSumBale_5',
                  },
                  {
                    'image': 'images/bale_10.png',
                    'sold': '$totDailySoldSumBale_10',
                    'given': '$totDailyGivenSumBale_10',
                  },
                  {
                    'image': 'images/slice.png',
                    'sold': '$totDailySoldSumSlice',
                    'given': '$totDailyGivenSumSlice',
                  },
                  {
                    'image': 'images/donut.png',
                    'sold': '$totDailySoldSumBombolino',
                    'given': '$totDailyGivenSumBombolino',
                  }
                ];

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
                            itemCount: whoLogged.length,
                            itemBuilder: (context, index) {
                              Provider.of<DataProvider>(context).binders(
                                  totalSumOfShop.toString(),
                                  totalSumOfShopGiven.toString());
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
                                              DateTime.parse(dataEntered
                                                  .last['producedDate']),
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
                                          Text(
                                              'Tot Daily Income: $totalSumOfShop',
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
                                          child: GridView.count(
                                            physics: const BouncingScrollPhysics(
                                                parent:
                                                    AlwaysScrollableScrollPhysics()),
                                            padding: EdgeInsets.all(_w / 20),
                                            crossAxisCount: columnCount,
                                            children: listOfPrice
                                                .map(
                                                  (e) => AnimationConfiguration
                                                      .staggeredGrid(
                                                    position: index,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    columnCount: columnCount,
                                                    child: ScaleAnimation(
                                                      duration: const Duration(
                                                          milliseconds: 900),
                                                      curve: Curves
                                                          .fastLinearToSlowEaseIn,
                                                      child: FadeInAnimation(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      _w / 30,
                                                                  left: _w / 60,
                                                                  right:
                                                                      _w / 60),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Image.asset(
                                                                e['image'],
                                                                width: 50,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      'Given',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w900),
                                                                    ),
                                                                    Text(e[
                                                                        'given']),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      'Sold',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w900),
                                                                    ),
                                                                    Text(e[
                                                                        'sold']),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
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
                  builder: (ctx) =>
                      ProductionInput(shopEmployeeEmail: dailyGiven),
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
      drawer: const Drawer(),
    );
  }
}
