import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UpdateOrderReceived extends StatefulWidget {
  var id = '';
  String existedName = '';
  String existedPhoneNumber = '';
  String existedOrderedKilo = '';
  String existedPricePerKG = '';
  String existedTotalAmount = '';
  String existedRemain = '';
  String existedDateTime = '';
  UpdateOrderReceived(
      {this.existedDateTime,
      this.id,
      this.existedName,
      this.existedOrderedKilo,
      this.existedPhoneNumber,
      this.existedPricePerKG,
      this.existedRemain,
      this.existedTotalAmount});
  @override
  State<UpdateOrderReceived> createState() => _UpdateOrderReceivedState();
}

class _UpdateOrderReceivedState extends State<UpdateOrderReceived> {
  String _message, body;
  String _canSendSMSMessage = 'Check is not run.';
  List<String> people = ['0923675686', '0917920560'];
  bool sendDirect = false;
  final formKey = GlobalKey<FormState>();
  String name = '';
  String phoneNumber = '';
  String orderedKilo = '';
  String pricePerKG = '';
  String totalAmount = '';
  String remain = '';
  String dateTime = DateTime.now().toString();
  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            dateTime = value.toString();
          } else {
            dateTime = DateTime.now().toString();
          }
        }));
  }

  Future<void> _sendSMS(String _messageBody, List<String> number) async {
    try {
      String _result = await sendSMS(
        message: _messageBody,
        recipients: number,
        sendDirect: sendDirect,
      );
      setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  Future<bool> _canSendSMS() async {
    bool _result = await canSendSMS();
    setState(() => _canSendSMSMessage =
        _result ? 'This unit can send SMS' : 'This unit cannot send SMS');
    return _result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'Update Order',
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
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
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
                    height: 5,
                  ),
                  TextFormField(
                    initialValue: widget.existedName,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter the name',
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
              padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    initialValue: widget.existedPhoneNumber,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Phone Number can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
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
              padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        width: 250,
                        height: 60,
                        child: Text(
                          'Date is set to : ${DateFormat.yMEd().format(DateTime.parse(dateTime))}',
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            datePicker();
                          });
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ordered Kilo',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.existedOrderedKilo,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            orderedKilo = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Kilo',
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
                    padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price/KG',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.existedPricePerKG,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            pricePerKG = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Price',
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
                          'Total Amount',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.existedTotalAmount,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            totalAmount = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Total',
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
                          'Remain',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.existedRemain,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            remain = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Remain',
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
            //button
            GestureDetector(
              onTap: () async {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  try {
                    await FirebaseFirestore.instance
                        .collection('OrderData')
                        .doc(widget.id)
                        .update({
                      'name': name,
                      'remain': remain,
                      'pricePerKG': pricePerKG,
                      'totalAmount': totalAmount,
                      'orderedKilo': orderedKilo,
                      'phoneNumber': phoneNumber,
                      'date': dateTime,
                      'orderReceivedDate': DateTime.now().toString()
                    });
                    Fluttertoast.showToast(
                        msg: "Updated",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 18.0);
                    _sendSMS(
                        '${orderedKilo}kg ለ ${DateFormat.E().format(
                          DateTime.parse(dateTime),
                        )}',
                        people);
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
                margin: const EdgeInsets.fromLTRB(130, 10, 130, 0),
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Center(
                  child: Text(
                    'Update',
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
