import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_trackers/models/expense.dart';
import 'package:transport_trackers/screen/add_expense_screen.dart';

import 'package:transport_trackers/widgets/app_drawer.dart';

import '../service/firestore_service.dart';
import '../widgets/expenses_list.dart';

class expensesListScreen extends StatelessWidget {
  static String routeName = '/expensesList';

  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<Expenses>>(
      stream: fsService.getExpenses(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting ?
        Center(child: CircularProgressIndicator()) :
          Scaffold(
          appBar: AppBar(
            title: Text('My Expense'),
          ),
          body: Container(
            alignment: Alignment.center,
            child: snapshot.data!.length > 0 ? ExpensesList():
                Column(
                  children: [
                    SizedBox(height: 30),
                    Image.asset('image_asset/file.png', width: 300),
                    Text('No expenses yet, add a new one today!', style: Theme.of(context).textTheme.subtitle1,)
                  ],
                )
          ),
          drawer: app_drawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
              {Navigator.of(context).pushNamed(addexpenseScreen.routeName);},
              child:Icon(Icons.add)
          ),
        );
      }
    );
  }
}
