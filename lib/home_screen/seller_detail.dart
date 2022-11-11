import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../data_provider.dart';
import '../other/constants.dart';

class SellerDetail extends StatefulWidget {
  const SellerDetail({Key key}) : super(key: key);

  @override
  State<SellerDetail> createState() => _SellerDetailState();
}

class _SellerDetailState extends State<SellerDetail> {
  bool isTapped = true;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    int selectedMonth = DateTime.now().month;
    final monthSelected = Provider.of<DataProvider>(context).monthOfAYear;
    List<String> imageOfBread = [
      'images/bale_5.png',
      'images/bale_10.png',
      'images/slice.png',
      'images/donut.png'
    ];
    List<String> swiperTitle = ['ባለ 5', 'ባለ 10', 'ስላይስ', 'ቦምቦሊኖ'];
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    // final summaryOrderData = Provider.of<OrderDataHub>(context).orderList;
    //  final filterByYearOrder = summaryOrderData
    //      .where((element) =>
    //          DateTime.parse(element['date']).year == DateTime.now().year)
    //      .toList();
    //  final filterByMonthOrder = filterByYearOrder
    //      .where((element) =>
    //          DateTime.parse(element['date']).month == selectedMonth)
    //      .toList();

    final yearFilter = Provider.of<DataProvider>(context).databaseDataForShop;
    final itemTypeForAdmin =
        yearFilter.where((element) => element['isWhat'] == 'given').toList();

    final employeeSoldYearFilterForAdmin = itemTypeForAdmin
        .where((element) =>
            DateTime.parse(element['givenDate']).year == DateTime.now().year)
        .toList();

    var employeeSoldMonthFilterForAdmin = employeeSoldYearFilterForAdmin
        .where((element) =>
            DateTime.parse(element['givenDate']).month == selectedMonth)
        .toList();
    // final yearFilterForProduction =
    //     Provider.of<DataProvider>(context).databaseDataForProduction;
    // final employeeSoldYearFilterForProduction = yearFilterForProduction
    //     .where((element) =>
    //         DateTime.parse(element['producedDate']).year == DateTime.now().year)
    //     .toList();
    //
    // var employeeSoldMonthFilterForProduction =
    //     employeeSoldYearFilterForProduction
    //         .where((element) =>
    //             DateTime.parse(element['producedDate']).month ==
    //             widget.selectedMonth)
    //         .toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 83, 151, 1),
          ),
        ),
        title: const Text('Daily Activities'),
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedMonth,
            items: monthSelected
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
                selectedMonth = value;
              });
            },
          ),
        ],
      ),
      body: employeeSoldMonthFilterForAdmin.isNotEmpty
          ? AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 22),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  final itemTypeForAdmin = yearFilter
                      .where((element) => element['isWhat'] == 'given')
                      .toList();

                  final employeeSoldYearFilterForAdmin = itemTypeForAdmin
                      .where((element) =>
                          DateTime.parse(element['givenDate']).year ==
                          DateTime.now().year)
                      .toList();

                  var employeeSoldMonthFilterForAdmin =
                      employeeSoldYearFilterForAdmin
                          .where((element) =>
                              DateTime.parse(element['givenDate']).month ==
                              selectedMonth)
                          .toList();
                  var employeeSoldDayFilterForAdmin =
                      employeeSoldMonthFilterForAdmin
                          .where((element) =>
                              DateTime.parse(element['givenDate']).day ==
                              (index + 1))
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
                  final itemType = yearFilter
                      .where((element) => element['isWhat'] == 'sold')
                      .toList();

                  final employeeSoldYearFilter = itemType
                      .where((element) =>
                          DateTime.parse(element['date']).year ==
                          DateTime.now().year)
                      .toList();

                  var employeeSoldMonthFilter = employeeSoldYearFilter
                      .where((element) =>
                          DateTime.parse(element['date']).month ==
                          selectedMonth)
                      .toList();
                  var employeeSoldDayFilter = employeeSoldMonthFilter
                      .where((element) =>
                          DateTime.parse(element['date']).day == (index + 1))
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
                  for (int xx = 0;
                      xx < totalEmployeeSoldBombolino.length;
                      xx++) {
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
                          : double.parse(
                              employeeSoldDayFilter.last['slice_Sp']));
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
                  double totalSold = (totalBale_5 +
                      totalBale_10 +
                      totalSlice +
                      totalBombolino);

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
                  int remainBale_5 = totalEmployeeSoldSumBale_5ForAdmin -
                      totalEmployeeSoldSumBale_5;
                  int remainBale_10 = totalEmployeeSoldSumBale_10ForAdmin -
                      totalEmployeeSoldSumBale_10;
                  int remainSlice = totalEmployeeSoldSumSliceForAdmin -
                      totalEmployeeSoldSumSlice;
                  int remainBombolino = totalEmployeeSoldSumBombolinoForAdmin -
                      totalEmployeeSoldSumBombolino;
                  final listOfPrice = [
                    {
                      'image': 'images/bale_5.png',
                      'sold': '$totalEmployeeSoldSumBale_5',
                      'given': '$totalEmployeeSoldSumBale_5ForAdmin',
                      'remain': '$remainBale_5'
                    },
                    {
                      'image': 'images/bale_10.png',
                      'sold': '$totalEmployeeSoldSumBale_10',
                      'given': '$totalEmployeeSoldSumBale_10ForAdmin',
                      'remain': '$remainBale_10'
                    },
                    {
                      'image': 'images/slice.png',
                      'sold': '$totalEmployeeSoldSumSlice',
                      'given': '$totalEmployeeSoldSumSliceForAdmin',
                      'remain': '$remainSlice'
                    },
                    {
                      'image': 'images/donut.png',
                      'sold': '$totalEmployeeSoldSumBombolino',
                      'given': '$totalEmployeeSoldSumBombolinoForAdmin',
                      'remain': '$remainBombolino'
                    }
                  ];

                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      margin:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 10),
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
                      height: 380,
                      width: 350,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Day - ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text('Daily Income: $totalSold ',
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
                                    parent: AlwaysScrollableScrollPhysics()),
                                padding: EdgeInsets.all(_w / 20),
                                crossAxisCount: columnCount,
                                children: listOfPrice
                                    .map((e) =>
                                        AnimationConfiguration.staggeredGrid(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          columnCount: columnCount,
                                          child: ScaleAnimation(
                                            duration: const Duration(
                                                milliseconds: 900),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            child: FadeInAnimation(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: _w / 60,
                                                    left: _w / 60,
                                                    right: _w / 60),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      e['image'],
                                                      width: 40,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Given',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                          Text(e['given']),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Sold',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                          Text(e['sold']),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Remain',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                          Text(e['remain']),
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
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/no-carbs.png',
                    width: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('No Activities This Month!')
                ],
              ),
            ),
    );
  }
}

class SwiperWidgets extends StatelessWidget {
  const SwiperWidgets({
    Key key,
    @required double w,
    @required this.dailyProduction,
    @required this.columnCount,
    @required this.imageOfBread,
  })  : _w = w,
        super(key: key);

  final double _w;
  final int columnCount;
  final List<Map<String, dynamic>> dailyProduction;
  final List<String> imageOfBread;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 16,
      child: AnimationLimiter(
        child: GridView.count(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(_w / 13),
          crossAxisCount: 1,
          children: dailyProduction
              .map(
                (e) => AnimationConfiguration.staggeredGrid(
                  position: 0,
                  duration: const Duration(milliseconds: 500),
                  columnCount: columnCount,
                  child: ScaleAnimation(
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: _w / 60, left: _w / 60, right: _w / 60),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              e['image'],
                              width: 55,
                            ),
                            buildDailyActivities(
                                'DailyProduced', e['production']),
                            buildDailyActivities('Sold', e['sold']),
                            e['show'] == 'false'
                                ? Container()
                                : buildDailyActivities(
                                    'Contract', e['contract']),
                            buildDailyActivities('Remain', e['remain']),
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
    );
  }

  Padding buildDailyActivities(String itemTitle, String itemDailyValue) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          Text(
            itemDailyValue,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
