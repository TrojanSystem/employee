import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UpdateExpense extends StatefulWidget {
  var index;
  String existedItemName;
  String existedItemDate;
  String existedItemPrice;
  String existedItemQuantity;
  String existedItemDescription;
  UpdateExpense({
    this.index,
    this.existedItemDate,
    this.existedItemDescription,
    this.existedItemName,
    this.existedItemPrice,
    this.existedItemQuantity,
  });

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            itemDate = value.toString();
          } else {
            itemDate = DateTime.now().toString();
          }
        }));
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _itemDescription = TextEditingController();
  TextEditingController _itemQuantity = TextEditingController();
  TextEditingController _itemPrice = TextEditingController();
  TextEditingController _itemDate = TextEditingController();

  String itemName = '';
  String itemDescription = '';
  String itemQuantity = '';
  String itemPrice = '';
  String itemDate = DateTime.now().toString();
  @override
  void dispose() {
    _itemName.dispose();
    _itemDescription.dispose();
    _itemQuantity.dispose();
    _itemPrice.dispose();
    _itemDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'Expenses',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const Divider(color: Colors.grey, thickness: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 28, 18, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.existedItemName,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      itemName = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.existedItemDescription,
                    maxLines: 3,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Description can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      itemDescription = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.existedItemPrice,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            itemPrice = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Price',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.existedItemQuantity,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            itemQuantity = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Quantity',
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 28, 18, 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        datePicker();
                      });
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  Text(
                    DateFormat.yMEd().format(DateTime.parse(itemDate)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();

                  try {
                    await FirebaseFirestore.instance
                        .collection('EmployeeExpenses')
                        .doc(widget.index)
                        .update({
                      'expenseType': 'employee',
                      'itemName': itemName,
                      'itemDate': itemDate,
                      'itemQuantity': itemQuantity,
                      'itemPrice': itemPrice,
                      'itemDescription': itemDescription,
                    });
                    _itemName.clear();
                    _itemQuantity.clear();
                    _itemPrice.clear();
                    _itemDescription.clear();
                    Fluttertoast.showToast(
                        msg: "Updated",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 18.0);

                    Navigator.of(context).pop();
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Error Occurred',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900),
                            ),
                            content: Text(e.toString(),
                                overflow: TextOverflow.visible),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('Ok'),
                              )
                            ],
                          );
                        });
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Center(
                  child: Text(
                    'Update Expense',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
