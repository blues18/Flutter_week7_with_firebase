import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transport_trackers/models/expense.dart';
import 'package:transport_trackers/provider/all_expenses.dart';
import 'package:transport_trackers/widgets/expenses_list.dart';

import 'screen/add_expense_screen.dart';
import 'screen/expense_ListScreen.dart';
import 'widgets/app_drawer.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Allexpenses>(
          create: (ctx) => Allexpenses(),
        ),
      ],
      child: MaterialApp(
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


  var form =GlobalKey<FormState>();

  String? purpose;

  String? mode;

  double? cost;

  DateTime? travelDate;

  List <Expenses> myExpenses = []; /* creating a list for expenses */


  void datePicker(BuildContext context ){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 14)),
        lastDate: DateTime.now()
    ).then((value){
      if(value==null)
        return;
        setState(() {
          travelDate =value;
        });
    });
  }

  void saveForm() {

    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();
      if (travelDate == null)travelDate =DateTime.now();
      print(purpose);
      print(mode);
      print(cost!.toStringAsFixed(2));
      print(DateFormat('dd/MM/yyyy').format(travelDate!));

      myExpenses.insert(0, Expenses(purpose: purpose!, mode: mode! ,cost: cost!, travelDate: travelDate!));

      FocusScope.of(context).unfocus();

      form.currentState!.reset();
      travelDate = null;

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Travel expense added successfully!'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Allexpenses expenseList = Provider.of<Allexpenses>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Transport Expreses Trackers'),
        actions: [
          IconButton(onPressed: saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Image.asset('image_asset/creditcard.png'),
          Text('Total spent: \$' + expenseList.getTotalSpendings().toStringAsFixed(2),
            style: Theme.of(context).textTheme.titleLarge,)
        ],
      ),
      drawer: app_drawer(),
    );
  }
}
