import 'package:cloud_firestore/cloud_firestore.dart';

class Expenses {
  String id;
  String purpose;
  String mode;
  double cost;
  DateTime travelDate;

  Expenses({required this.id, required this.purpose, required this.mode, required this.cost, required this.travelDate});

  Expenses.fromMap(Map <String, dynamic> snapshot,String id):
        id =id,
        purpose = snapshot['purpose'] ?? '',
        mode = snapshot['mode'] ?? '',
        cost = snapshot['cost'] ?? '',
        travelDate = (snapshot['travelDate'] ?? Timestamp.now() as
        Timestamp).toDate();

}