import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_storage.dart';

class MyCustomBottomNavigationBar extends StatefulWidget {
  @override
  _MyCustomBottomNavigationBarState createState() =>
      _MyCustomBottomNavigationBarState();
}

class _MyCustomBottomNavigationBarState
    extends State<MyCustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: CurvedNavigationBar(
        height: 50,
        onTap: (value) {
          setState(() {
            Provider.of<DataStorage>(context, listen: false)
                .currentIndex(value);
          });
        },
        index: 0,
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        items: const [
          Image(
            image: AssetImage('images/home.png'),
            width: 30,
          ),
          Image(
            image: AssetImage('images/order-now.png'),
            width: 30,
          ),
          Image(
            image: AssetImage('images/expenses.png'),
            width: 30,
          ),
        ],
      ),
    );
  }
}
