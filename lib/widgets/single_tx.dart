import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class SingleTransaction extends StatefulWidget {
  final Key key;
  final Transaction transaction;
  final Function deleteTransaction;

  SingleTransaction({this.key, this.transaction, this.deleteTransaction})
      : super(key: key);

  @override
  _SingleTransactionState createState() => _SingleTransactionState();
}

class _SingleTransactionState extends State<SingleTransaction> {
  Color bgColor;

  @override
  void initState() {
    super.initState();
    const List<Color> availableColors = [
      Colors.cyan,
      Colors.blueGrey,
      Colors.lightGreenAccent,
      Colors.deepPurpleAccent,
      Colors.yellow,
      Colors.blue,
      Colors.red,
    ];
    bgColor = availableColors[Random().nextInt(7)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
          // Amount
          leading: CircleAvatar(
            radius: 30,
            // backgroundColor: Theme.of(context).primaryColorLight,
            backgroundColor: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child:
                    Text("\$${widget.transaction.amount.toStringAsFixed(2)}"),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transaction.date),
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          trailing: FlatButton.icon(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () => widget.deleteTransaction(widget.transaction.id),
            label: const Text('DELETE'),
            textColor: Theme.of(context).errorColor,
          )),
    );
  }
}

// trailing by using bodyWidth
/*
trailing: bodyWidth > 400
            ? FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => widget.deleteTransaction(widget._transaction.id),
                label: const Text('DELETE'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => widget.deleteTransaction(widget._transaction.id),
              ),
*/


// transaction: without trash icon
/*
return Card(
      elevation: 5,
      child: Row(
        children: [
          // Amount
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight,
            ),
            child: Container(
              width: 65,
              height: 65,
              child: FittedBox(
                child: Text(
                  "\$${widget._transaction.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    // color: Theme.of(context).primaryColorDark,
                    color: bgColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._transaction.title,
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                DateFormat.yMMMd().format(widget._transaction.date),
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ],
      ),
    );
  
*/
