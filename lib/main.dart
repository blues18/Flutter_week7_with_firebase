import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var form =GlobalKey<FormState>();

  String? purpose;

  String? mode;

  double? cost;

  DateTime? travelDate;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport Expreses Trackers'),
        actions: [
          IconButton(onPressed: saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: form,
          child: Column(
            children: [
              DropdownButtonFormField(
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
                  onChanged: (value) {mode = value as String; }
              ),
                TextFormField(
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
                    onPressed: () {datePicker(context);},
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
