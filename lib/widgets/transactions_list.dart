import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/single_tx.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    var bodyHeight = MediaQuery.of(context).size.height;
    var bodyWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 520,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction! add some transaction',
                  // because capurtino don't use default theme
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : Column(
              children: [
                ...transactions
                    .map(
                      (tx) => SingleTransaction(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTransaction: deleteTransaction,
                      ),
                    )
                    .toList()
              ],
            ), // map
    );
  }
}

// using ListTile
/*
return Container(
      height: 520,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction! add some transaction',
                  // because capurtino don't use default theme
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ibCtx, index) {
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
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              "\$${transactions[transactions.length - index - 1].amount.toStringAsFixed(2)}"),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[transactions.length - index - 1].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                          transactions[transactions.length - index - 1].date),
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    trailing: bodyWidth > 400
                        ? FlatButton.icon(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () => deleteTransaction(
                                transactions[transactions.length - index - 1]
                                    .id),
                            label: const Text('DELETE'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () => deleteTransaction(
                                transactions[transactions.length - index - 1]
                                    .id),
                          ),
                  ),
                );
              },
            ),
    );
  
*/

// uising our defined single_tx
/*
Container(
    height: 450,
    child: ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ibCtx, index) {
        return SingleTransaction(
          transactions[
              transactions.length - index - 1] // new tx show at top
        );
      },
    ),
  );
*/



