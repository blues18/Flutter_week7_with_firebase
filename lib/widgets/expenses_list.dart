import 'package:flutter/material.dart';
import 'package:transport_trackers/models/expense.dart';

class expensesList extends StatelessWidget {

  List <Expenses> myExpenses;
  Function removedItem;

  expensesList(this.myExpenses, this.removedItem);


  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (ctx, i)
    {
      return ListTile(
        leading: CircleAvatar(child: Text(myExpenses[i].mode),),
        title: Text(myExpenses[i].purpose),
        subtitle: Text(myExpenses[i].cost.toStringAsFixed(2)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            removedItem(i);
            },
          ),
        );
      },
    itemCount: myExpenses.length,
    separatorBuilder: (ctx, i) {
      return Divider(height: 3,color: Colors.blueGrey);
      },
    );
  }
}
