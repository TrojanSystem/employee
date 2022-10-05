import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data_storage.dart';
import '../order_screen/expense.dart';
import '../order_screen/income.dart';
import '../order_screen/order_data_hub.dart';
import '../other/constants.dart';

int totIncome = 0;

class ShopAnalysis extends StatefulWidget {
  final List monthlyOrder;
  const ShopAnalysis({Key key, this.monthlyOrder}) : super(key: key);

  @override
  State<ShopAnalysis> createState() => _ShopAnalysisState();
}

class _ShopAnalysisState extends State<ShopAnalysis> {
  int selectedMonth = DateTime.now().month;
  double totOrderedKg = 0;
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final monthSelected = Provider.of<DataStorage>(context).monthOfAYear;

    var orderListDetail = widget.monthlyOrder
        .where(
            (element) => DateTime.parse(element['date']).month == selectedMonth)
        .toList();

    double totPriceOrder = 0;
    // var quantityOfBread = orderListDetail.map((e) => e['orderedKilo']).toList();
    //
    // var priceOfBread = orderListDetail.map((e) => e['totalAmount']).toList();
    // for (int x = 0; x < priceOfBread.length; x++) {
    //   totPriceOrder += double.parse(priceOfBread[x]);
    // }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromRGBO(40, 53, 147, 1),
              const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
        ),
        title: const Text('Shop Analysis'),
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
                      e['month'],
                      style: kkDropDown,
                    ),
                    value: e['days'],
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
      body: Consumer<OrderDataHub>(
        builder: (context, data, child) => Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Income(totPrice: totPriceOrder),
                  Expense(total: totOrderedKg),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(_w / 30),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: orderListDetail.length,
                  itemBuilder: (BuildContext context, int index) {
                    totIncome = orderListDetail.isEmpty
                        ? 0
                        : ((int.parse(orderListDetail[index]['bale_5']) *
                                int.parse(
                                    orderListDetail[index]['bale_5_Sp'])) +
                            (int.parse(orderListDetail[index]['bale_10']) *
                                int.parse(
                                    orderListDetail[index]['bale_10_Sp'])) +
                            (int.parse(orderListDetail[index]['slice']) *
                                int.parse(orderListDetail[index]['slice_Sp'])) +
                            (int.parse(orderListDetail[index]['bombolino']) *
                                int.parse(
                                    orderListDetail[index]['bombolino_Sp'])));

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        horizontalOffset: -300,
                        verticalOffset: -850,
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              const SizedBox(
                                width: 50,
                              ),
                              IconButton(
                                color: Colors.red,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete_forever,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                color: Colors.green,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          totIncome.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'ETB',
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, top: 15),
                                        child: Text(
                                          DateFormat.yMMMEd().format(
                                            DateTime.parse(
                                                orderListDetail[index]['date']),
                                          ),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'ባለ 5 ፡ ${orderListDetail[index]['bale_5']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'ባለ 10 ፡ ${orderListDetail[index]['bale_10']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'ቦምቦሊኖ ፡ ${orderListDetail[index]['bombolino']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'ስላይስ ፡ ${orderListDetail[index]['slice']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                      //
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(bottom: _w / 20),
                            height: _w / 3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
