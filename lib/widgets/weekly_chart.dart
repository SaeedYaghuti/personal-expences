import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'daily_chart.dart';

// class DailySummery {
//   double sun = 0.0;
//   double mon = 0.0;
//   double tue = 0.0;
//   double wen = 0.0;
//   double tur = 0.0;
//   double fri = 0.0;
//   double sat = 0.0;
//   double total = 0.0;
// }
class DailySummery {
  double sun = 0.0;
  double mon = 0.0;
  double tue = 0.0;
  double wen = 0.0;
  double tur = 0.0;
  double fri = 0.0;
  double sat = 0.0;
  double total = 0.0;
}

class WeeklyChart extends StatelessWidget {
  final List<Transaction> lastWeekTransactions;

  WeeklyChart(this.lastWeekTransactions);

  List<double> get dailySummery {
    // print('lastweektransaction> ');
    // print(lastWeekTransactions);

    // summery[0] => total,
    // summery[1] => monday,
    // ...
    // summary[5] => friday
    // summary[6] => saturday
    // summery[7] => sunday,
    List<double> summery = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    for (var tx in lastWeekTransactions) {
      // add amount to weekday
      summery[tx.date.weekday] += tx.amount;
      // add amount to weekly-total
      summery[0] += tx.amount;
    }

    return summery;
  }

  List<double> get summaryEndToday {
    List<double> summaryEndToday = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    var dailySummeryOutput = dailySummery;

    // print('dailySummeryOutput: >');
    // print(dailySummeryOutput);

    summaryEndToday[0] = dailySummery[0]; // take total

    int todayWeekDay = DateTime.now().weekday;

    for (int i = 1; i <= 7; i++) {
      int index = (todayWeekDay + i) % 7;
      if (index == 0) {
        index = 7;
      }
      // print('index: >');
      // print(index);

      summaryEndToday[i] += dailySummeryOutput[index];
    }
    // print('summaryEndToday: >');
    // print(summaryEndToday);

    return summaryEndToday;
  }

  @override
  Widget build(BuildContext context) {
    var summery = summaryEndToday;
    double totalAmount = summery[0];
    int todayWeekDay = DateTime.now().weekday;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: Card(
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (int i = 1; i < summery.length; i++)
                Flexible(
                  fit: FlexFit.tight,
                  child: DailyChart(
                    amount: summery[i],
                    weekDay: (todayWeekDay + i) % 7 == 0
                        ? 7
                        : (todayWeekDay + i) % 7,
                    totalAmount: totalAmount,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  } // widget
}

/*
return list
        .asMap()
        .map((index, value) =>
            MapEntry(index, _buildWidget(index, value)))
        .values
        .toList();
*/

/*
myList.asMap().entries.map((entry) {
    int idx = entry.key;
    String val = entry.value;

    return something;
}

*/


/*
summery.asMap().forEach(
          (index, amount) {
            if (index != 0) {
              return DailyChart(
                weekDay: index,
                amount: amount,
                totalAmount: totalAmount,
              );
            } else {
              return null;
            }//if
          }), 
*/
