import 'package:flutter/material.dart';
import 'package:transport_trackers/main.dart';
import 'package:transport_trackers/screen/expense_ListScreen.dart';

class app_drawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Hello'),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('home'),
          onTap: () =>
          Navigator.of(context).pushReplacementNamed(MainScreen.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text('My Expenses'),
          onTap: () =>
          Navigator.of(context).pushReplacementNamed(expensesListScreen.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
      ]),
    );
  }
}
