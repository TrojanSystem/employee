import 'package:ada_bread/data_provider.dart';
import 'package:ada_bread/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_storage.dart';
import 'expense_screen/data_storage/expenses_data.dart';
import 'order_screen/order_data_hub.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DataStorage(),
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => DataProvider()
              ..loadLoggedUser()
              ..loadSoldList()
            // ..loadExpenseList(),
            ),
        ChangeNotifierProvider(
          create: (BuildContext context) => OrderDataHub(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ExpensesData(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyCustomSplashScreen(),
      ),
    ),
  );
}
