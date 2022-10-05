import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data_storage.dart';
import '../other/constants.dart';
import 'expense.dart';
import 'income.dart';
import 'order_data_hub.dart';

class OrderListItem extends StatefulWidget {
  final List monthlyOrder;
  const OrderListItem({this.monthlyOrder});

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final monthSelected = Provider.of<DataStorage>(context).monthOfAYear;

    final result = widget.monthlyOrder
        .where((element) =>
            DateTime.parse(element['date']).year == DateTime.now().year)
        .toList();

    var orderListDetail = result
        .where(
            (element) => DateTime.parse(element['date']).month == selectedMonth)
        .toList();

    double totOrderedKg = 0;
    double totPriceOrder = 0;
    var quantityOfBread = orderListDetail.map((e) => e['orderedKilo']).toList();

    var priceOfBread = orderListDetail.map((e) => e['totalAmount']).toList();
    for (int x = 0; x < priceOfBread.length; x++) {
      totPriceOrder += double.parse(priceOfBread[x]);
    }
    for (int x = 0; x < quantityOfBread.length; x++) {
      totOrderedKg += double.parse(quantityOfBread[x]);
    }
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
        title: const Text('Order List'),
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
                                          orderListDetail[index]['totalAmount'],
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
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          orderListDetail[index]['name'],
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat.yMMMEd().format(
                                          DateTime.parse(
                                              orderListDetail[index]['date']),
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'KG',
                                            style: TextStyle(
                                              color: Colors.green[800],
                                              fontFamily: 'FjallaOne',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            orderListDetail[index]
                                                    ['orderedKilo']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.green[800],
                                              fontFamily: 'FjallaOne',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
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
                            height: _w / 4,
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
