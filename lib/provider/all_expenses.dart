import 'package:flutter/material.dart';
import 'package:transport_trackers/models/expense.dart';

class Allexpenses with ChangeNotifier {

  List<Expenses> myExpenses = [];

  List<Expenses> getMyExpenses() {
    return myExpenses;
  }
  void addExpense (purpose, mode, cost, travelDate) {
    myExpenses.insert(0, Expenses(purpose: purpose, mode: mode, cost: cost, travelDate: travelDate));
    notifyListeners();
  }
  void removedExpenses(i) {
    myExpenses.removeAt(i);
    notifyListeners();
  }
  double getTotalSpendings() {
    double sum = 0;

    myExpenses.forEach((element) {sum += element.cost;});

    return sum;
  }

}
