import 'package:flutter/foundation.dart';

class Transaction {
  final Key key;
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.key,
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });

  String toString() {
    return '\n{ > title: $title, weekday: ${date.weekday}, amount: $amount }';
  }
}
