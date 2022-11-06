import 'package:ada_bread/expense_screen/update_expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatefulWidget {
  final List dailyExpense;
  ExpenseItem({this.dailyExpense});

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  // final int index;
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 22),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: widget.dailyExpense.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              horizontalOffset: -300,
              verticalOffset: -850,
              child: Container(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat.yMMMEd().format(
                                  DateTime.parse(
                                      widget.dailyExpense[index]['itemDate']),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.dailyExpense[index]['itemName'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${widget.dailyExpense[index]['itemDescription']}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => UpdateExpense(
                                            index:
                                            (widget.dailyExpense[index].id),
                                            existedItemName:
                                            widget.dailyExpense[index]
                                            ['itemName'],
                                            existedItemDate:
                                            widget.dailyExpense[index]
                                            ['itemDate'],
                                            existedItemPrice:
                                            widget.dailyExpense[index]
                                            ['itemPrice'],
                                            existedItemQuantity:
                                            widget.dailyExpense[index]
                                            ['itemQuantity'],
                                            existedItemDescription:
                                            widget.dailyExpense[index]
                                            ['itemDescription'],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                      size: 25,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        FirebaseFirestore.instance
                                            .collection('EmployeeExpenses')
                                            .doc(widget.dailyExpense[index].id)
                                            .delete();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 120,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.arrow_upward_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            const Text(
                              'ETB ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.dailyExpense[index]['itemPrice'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: _w / 20),
                height: _w / 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
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
          );
        },
      ),
    );
  }
}
