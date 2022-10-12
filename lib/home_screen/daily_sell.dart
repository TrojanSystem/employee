import 'package:ada_bread/data_provider.dart';
import 'package:ada_bread/data_storage.dart';
import 'package:ada_bread/home_screen/production_input.dart';
import 'package:ada_bread/home_screen/shop_analysis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../drawer/custom_drawer.dart';
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

  var totalExpectedIncome;
  int updateIndex = 0;
  bool isTapped = true;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;
  int selectedDayOfMonth = DateTime.now().day;

  @override
  void initState() {
    totalExpectedIncome;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    final loggedEmail = Provider.of<DataProvider>(context).loggedUserEmail;
    final totalExpectedIncome =
        Provider.of<DataProvider>(context).totalAppbarExpectedIncome;
    final totalSoldIncome =
        Provider.of<DataProvider>(context).totalAppbarSoldIncome;
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
                            'Expected Income: $totalExpectedIncome',
                            style: dailyIncomeStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Tot Sold: $totalSoldIncome',
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
                productionData = snapshot.data.docs;
                /*
                *
                * GIVEN ITEM
                *
                *
                * */

                final itemTypeForAdmin = productionData
                    .where((element) => element['isWhat'] == 'given')
                    .toList();
                final whoIsForAdmin = itemTypeForAdmin
                    .where((element) => element['seller'] == loggedEmail)
                    .toList();
                final employeeSoldYearFilterForAdmin = whoIsForAdmin
                    .where((element) =>
                        DateTime.parse(element['givenDate']).year ==
                        DateTime.now().year)
                    .toList();

                var employeeSoldMonthFilterForAdmin =
                    employeeSoldYearFilterForAdmin
                        .where((element) =>
                            DateTime.parse(element['givenDate']).month ==
                            DateTime.now().month)
                        .toList();
                var employeeSoldDayFilterForAdmin =
                    employeeSoldMonthFilterForAdmin
                        .where((element) =>
                            DateTime.parse(element['givenDate']).day ==
                            selectedDayOfMonth)
                        .toList();
                /*
                *
                *
                *
                *
                * */

                /*


                  BALE 5 ForAdmin
                *
                *
                *
                * */
                var totalEmployeeSoldBale_5ForAdmin =
                    employeeSoldDayFilterForAdmin
                        .map((e) => e['bale_5'])
                        .toList();

                var totalEmployeeSoldSumBale_5ForAdmin = 0;
                for (int xx = 0;
                    xx < totalEmployeeSoldBale_5ForAdmin.length;
                    xx++) {
                  totalEmployeeSoldSumBale_5ForAdmin +=
                      int.parse(totalEmployeeSoldBale_5ForAdmin[xx]);
                }

                /*


                  BALE 10 ForAdmin
                *
                *
                *
                * */
                var totalEmployeeSoldBale_10ForAdmin =
                    employeeSoldDayFilterForAdmin
                        .map((e) => e['bale_10'])
                        .toList();

                var totalEmployeeSoldSumBale_10ForAdmin = 0;
                for (int xx = 0;
                    xx < totalEmployeeSoldBale_10ForAdmin.length;
                    xx++) {
                  totalEmployeeSoldSumBale_10ForAdmin +=
                      int.parse(totalEmployeeSoldBale_10ForAdmin[xx]);
                }
                /*


                   SLICE ForAdmin
                *
                *
                *
                * */
                var totalEmployeeSoldSliceForAdmin =
                    employeeSoldDayFilterForAdmin
                        .map((e) => e['slice'])
                        .toList();

                var totalEmployeeSoldSumSliceForAdmin = 0;
                for (int xx = 0;
                    xx < totalEmployeeSoldSliceForAdmin.length;
                    xx++) {
                  totalEmployeeSoldSumSliceForAdmin +=
                      int.parse(totalEmployeeSoldSliceForAdmin[xx]);
                }
                /*


                 BOMBOLINO ForAdmin
                *
                *
                *
                * */
                var totalEmployeeSoldBombolinoForAdmin =
                    employeeSoldDayFilterForAdmin
                        .map((e) => e['bombolino'])
                        .toList();

                var totalEmployeeSoldSumBombolinoForAdmin = 0;
                for (int xx = 0;
                    xx < totalEmployeeSoldBombolinoForAdmin.length;
                    xx++) {
                  totalEmployeeSoldSumBombolinoForAdmin +=
                      int.parse(totalEmployeeSoldBombolinoForAdmin[xx]);
                }

                /*
                *
                * TOTAL EXPECTED INCOME BALE_5
                *
                *
                * */
                final double totalBale_5ForAdmin =
                    totalEmployeeSoldSumBale_5ForAdmin *
                        (employeeSoldDayFilterForAdmin.isEmpty
                            ? 0.0
                            : double.parse(employeeSoldDayFilterForAdmin
                                .last['bale_5_Sp']));
                /*
                *
                * TOTAL EXPECTED INCOME BALE_10
                *
                *
                * */
                final double totalBale_10ForAdmin =
                    totalEmployeeSoldSumBale_10ForAdmin *
                        (employeeSoldDayFilterForAdmin.isEmpty
                            ? 0.0
                            : double.parse(employeeSoldDayFilterForAdmin
                                .last['bale_10_Sp']));
                /*
                *
                * TOTAL EXPECTED INCOME SLICE
                *
                *
                * */
                final double totalSliceForAdmin =
                    totalEmployeeSoldSumSliceForAdmin *
                        (employeeSoldDayFilterForAdmin.isEmpty
                            ? 0.0
                            : double.parse(employeeSoldDayFilterForAdmin
                                .last['slice_Sp']));
                /*
                *
                * TOTAL EXPECTED INCOME BOMBOLINO
                *
                *
                * */
                final double totalBombolinoForAdmin =
                    totalEmployeeSoldSumBombolinoForAdmin *
                        (employeeSoldDayFilterForAdmin.isEmpty
                            ? 0.0
                            : double.parse(employeeSoldDayFilterForAdmin
                                .last['bombolino_Sp']));

                /*
                *
                * SOLD ITEM
                *
                *
                * */
                final itemType = productionData
                    .where((element) => element['isWhat'] == 'sold')
                    .toList();
                final whoIs = itemType
                    .where((element) => element['employeeEmail'] == loggedEmail)
                    .toList();
                final employeeSoldYearFilter = whoIs
                    .where((element) =>
                        DateTime.parse(element['date']).year ==
                        DateTime.now().year)
                    .toList();

                var employeeSoldMonthFilter = employeeSoldYearFilter
                    .where((element) =>
                        DateTime.parse(element['date']).month ==
                        DateTime.now().month)
                    .toList();
                var employeeSoldDayFilter = employeeSoldMonthFilter
                    .where((element) =>
                        DateTime.parse(element['date']).day ==
                        selectedDayOfMonth)
                    .toList();
                /*


                  BALE 5
                *
                *
                *
                * */
                var totalEmployeeSoldBale_5 =
                    employeeSoldDayFilter.map((e) => e['bale_5']).toList();

                var totalEmployeeSoldSumBale_5 = 0;
                for (int xx = 0; xx < totalEmployeeSoldBale_5.length; xx++) {
                  totalEmployeeSoldSumBale_5 +=
                      int.parse(totalEmployeeSoldBale_5[xx]);
                }

                /*


                  BALE 10
                *
                *
                *
                * */
                var totalEmployeeSoldBale_10 =
                    employeeSoldDayFilter.map((e) => e['bale_10']).toList();

                var totalEmployeeSoldSumBale_10 = 0;
                for (int xx = 0; xx < totalEmployeeSoldBale_10.length; xx++) {
                  totalEmployeeSoldSumBale_10 +=
                      int.parse(totalEmployeeSoldBale_10[xx]);
                }
                /*


                   SLICE
                *
                *
                *
                * */
                var totalEmployeeSoldSlice =
                    employeeSoldDayFilter.map((e) => e['slice']).toList();

                var totalEmployeeSoldSumSlice = 0;
                for (int xx = 0; xx < totalEmployeeSoldSlice.length; xx++) {
                  totalEmployeeSoldSumSlice +=
                      int.parse(totalEmployeeSoldSlice[xx]);
                }
                /*


                 BOMBOLINO
                *
                *
                *
                * */
                var totalEmployeeSoldBombolino =
                    employeeSoldDayFilter.map((e) => e['bombolino']).toList();

                var totalEmployeeSoldSumBombolino = 0;
                for (int xx = 0; xx < totalEmployeeSoldBombolino.length; xx++) {
                  totalEmployeeSoldSumBombolino +=
                      int.parse(totalEmployeeSoldBombolino[xx]);
                }
                /*
                *
                * TOTAL INCOME BALE_5
                *
                *
                * */
                final double totalBale_5 = totalEmployeeSoldSumBale_5 *
                    (employeeSoldDayFilter.isEmpty
                        ? 0.0
                        : double.parse(
                            employeeSoldDayFilter.last['bale_5_Sp']));
                /*
                *
                * TOTAL INCOME BALE_10
                *
                *
                * */
                final double totalBale_10 = totalEmployeeSoldSumBale_10 *
                    (employeeSoldDayFilter.isEmpty
                        ? 0.0
                        : double.parse(
                            employeeSoldDayFilter.last['bale_10_Sp']));
                /*
                *
                * TOTAL INCOME SLICE
                *
                *
                * */
                final double totalSlice = totalEmployeeSoldSumSlice *
                    (employeeSoldDayFilter.isEmpty
                        ? 0.0
                        : double.parse(employeeSoldDayFilter.last['slice_Sp']));
                /*
                *
                * TOTAL INCOME BOMBOLINO
                *
                *
                * */
                final double totalBombolino = totalEmployeeSoldSumBombolino *
                    (employeeSoldDayFilter.isEmpty
                        ? 0.0
                        : double.parse(
                            employeeSoldDayFilter.last['bombolino_Sp']));

                /*
                *
                *
                *
                * Sum of ALL SOLD ITEMS
                *
                *
                *
                *
                * */
                final listOfPrice = [
                  {
                    'image': 'images/bale_5.png',
                    'sold': '$totalEmployeeSoldSumBale_5',
                    'given': '$totalEmployeeSoldSumBale_5ForAdmin',
                  },
                  {
                    'image': 'images/bale_10.png',
                    'sold': '$totalEmployeeSoldSumBale_10',
                    'given': '$totalEmployeeSoldSumBale_10ForAdmin',
                  },
                  {
                    'image': 'images/slice.png',
                    'sold': '$totalEmployeeSoldSumSlice',
                    'given': '$totalEmployeeSoldSumSliceForAdmin',
                  },
                  {
                    'image': 'images/donut.png',
                    'sold': '$totalEmployeeSoldSumBombolino',
                    'given': '$totalEmployeeSoldSumBombolinoForAdmin',
                  }
                ];
                double totalSold =
                    (totalBale_5 + totalBale_10 + totalSlice + totalBombolino);
                double expectedIncome = (totalBale_5ForAdmin +
                    totalBale_10ForAdmin +
                    totalSliceForAdmin +
                    totalBombolinoForAdmin);

                int sumOfSoldItem = (totalEmployeeSoldSumBale_5 +
                    totalEmployeeSoldSumBale_10 +
                    totalEmployeeSoldSumSlice +
                    totalEmployeeSoldSumBombolino);
                int sumOfGivenItems = (totalEmployeeSoldSumBale_5ForAdmin +
                    totalEmployeeSoldSumBale_10ForAdmin +
                    totalEmployeeSoldSumSliceForAdmin +
                    totalEmployeeSoldSumBombolinoForAdmin);
                Provider.of<DataProvider>(context).binders(
                    sumOfSoldItem.toString(), sumOfGivenItems.toString());
                Provider.of<DataProvider>(context).totalIncome(
                    totalSold.toString(), expectedIncome.toString());
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 3,
                        ),
                      )
                    : ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat.E().format(
                                          DateTime.parse(
                                              DateTime.now().toString()),
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
                                      Text('Tot Daily Income: $totalSold',
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
                                            .map((e) => AnimationConfiguration
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
                                                        margin: EdgeInsets.only(
                                                            bottom: _w / 30,
                                                            left: _w / 60,
                                                            right: _w / 60),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
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
                                                                      .all(8.0),
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
                                                                      .all(8.0),
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
                                                ))
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
                      ProductionInput(shopEmployeeEmail: loggedEmail),
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
      drawer: const CustomDrawer(),
    );
  }
}
