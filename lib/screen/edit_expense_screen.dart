import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transport_trackers/models/expense.dart';
import 'package:transport_trackers/widgets/expenses_list.dart';

import '../service/firestore_service.dart';

class EditexpenseScreen extends StatefulWidget {
  static String routeName ='/edit-expense';

  @override
  State<EditexpenseScreen> createState() => _EditexpenseScreenState();
}

class _EditexpenseScreenState extends State<EditexpenseScreen> {
  var form = GlobalKey<FormState>();

  String? purpose;
  String? mode;
  double? cost;
  DateTime? travelDate;

  void saveForm(String id) {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();
      if(travelDate == null)travelDate =DateTime.now();

      print(purpose);
      print(mode);
      print(cost!.toStringAsFixed(2));

      FirestoreService fsService = FirestoreService();
      fsService.editExpense(id, purpose, mode, cost, travelDate);
      //hiding keyboard
      FocusScope.of(context).unfocus();

      //reset the form
      /*form.currentState!.reset();
      travelDate = null;*/

      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Travel expense Update successfully!'),)
      );
      Navigator.of(context).pop();
    }
  }
  void presentDatePicker(BuildContext context) {
    showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 14)),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value==null) return;

      setState(() {
        travelDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Expenses selectedExpense = ModalRoute.of(context)?.settings.arguments as
    Expenses;
      travelDate = selectedExpense.travelDate;

      if(travelDate == null)travelDate = selectedExpense.travelDate;

    return Scaffold(
      appBar: AppBar(
        title: Text('edit expense'),
        actions: [
          IconButton(onPressed:() { saveForm(selectedExpense.id);}, icon: Icon(Icons.save))
        ],
      ),
      body:Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: form,
          child: Column(
            children: [
              DropdownButtonFormField(
                value: selectedExpense.mode,
                  decoration: InputDecoration(
                      label: Text('Mode of Transport')
                  ),
                  items: [
                    DropdownMenuItem(child: Text('Bus'),value: 'bus'),
                    DropdownMenuItem(child: Text('Grab'),value: 'grab'),
                    DropdownMenuItem(child: Text('Mrt'),value: 'mrt'),
                    DropdownMenuItem(child: Text('Taxi'),value: 'taxi'),
                  ],
                  validator: (value) {
                    if(value == null)
                      return 'please provide a mode of transport';
                    else
                      return null;
                  },
                  onChanged: (value) {mode = value as String; },
                  onSaved: (value) {mode =value as String; },
              ),
              TextFormField(
                initialValue: selectedExpense.cost.toStringAsFixed(2),
                decoration: InputDecoration(
                    label: Text('cost')
                ),
                keyboardType: TextInputType.number, //Swicthing to number keyboard type
                validator: (value) {
                  if (value == null)
                    return 'please enter the Cost of transport ';
                  else if (double.tryParse(value) == null)
                    return 'please provide a vaild travel cost';
                  else
                    return null;
                },
                onSaved: (value) {cost = double.parse(value!);},
              ),
              TextFormField(
                initialValue: selectedExpense.purpose,
                decoration: InputDecoration(
                    label: Text('Purpose')
                ),
                validator: (value) {
                  if (value == null)
                    return 'please enter the purpose of your transport';
                  else if (value.length < 5)
                    return 'please enter a description that is at least 5 letters long.';
                  else
                    return null;
                },
                onSaved: (value) {purpose = value as String;},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(travelDate==null? 'No Date chosen': 'Picked Date ' + DateFormat('dd/MM/yyyy').format(travelDate!)),//converting stateless widget to stateful
                  TextButton(
                    child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {presentDatePicker(context);},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
