import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:transport_trackers/models/expense.dart';
import 'package:transport_trackers/service/firestore_service.dart';

import 'screen/add_expense_screen.dart';
import 'screen/expense_ListScreen.dart';
import 'widgets/app_drawer.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) => MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        addexpenseScreen.routeName : (_) {return addexpenseScreen();},
        expensesListScreen.routeName : (_) {return expensesListScreen();},
        }
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<Expenses>>(
        stream: fsService.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            double sum = 0;
            snapshot.data!.forEach((doc) {
              sum += doc.cost;
            });
            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('Transport Expreses Trackers'),
              ),
              body: Column(
                children: [
                  Image.asset('image_asset/creditcard.png'),
                  Text('Total spent: \$' + sum.toStringAsFixed(2),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,)
                ],
              ),
              drawer: app_drawer(),
            );
          }
        }
    );
  }
}

