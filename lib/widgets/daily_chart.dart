import 'package:flutter/material.dart';

class DailyChart extends StatelessWidget {
  final int weekDay;
  final double amount;
  final double totalAmount;
  const DailyChart({this.weekDay, this.amount, this.totalAmount});

  String get day {
    switch (weekDay) {
      case 1:
        return "M";
        break;
      case 2:
        return "T";
        break;
      case 3:
        return "W";
        break;
      case 4:
        return "T";
        break;
      case 5:
        return "F";
        break;
      case 6:
        return "S";
        break;

      case 7:
        return "S";
        break;
      default:
        return "X";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              // height: 16,
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${amount.toStringAsFixed(0)}'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: constraints.maxHeight * 0.05,
              ),
              height: constraints.maxHeight * 0.6,
              // height: 60,
              width: 10,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 237, 237),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                heightFactor: totalAmount == 0.0 ? 0.0 : (amount / totalAmount),
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(day),
              ),
            ),
          ],
        );
      }, // builder
    );
  }
}

// daily-chart: inside-containers; without LayoutBuilder
// @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 16,
//           child: FittedBox(
//             child: Text('\$${amount.toStringAsFixed(0)}'),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 6),
//           height: 60,
//           width: 10,
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 235, 237, 237),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: FractionallySizedBox(
//             heightFactor: totalAmount == 0.0 ? 0.0 : (amount / totalAmount),
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//         ),
//         Text(day),
//       ],
//     );

    // return Column(
    //   children: [
    //     Text('\$$amount'),
    //     Text(
    //         '${totalAmount == 0.0 ? 0.0 : (amount / totalAmount).toStringAsFixed(1)}'),
    //     Text(day),
    //   ],
    // );
  // }




// daily-chert: stack; => fraction show at top
/*
@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$$amount'),
        Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            height: 60,
            width: 10,
            // decoration: BoxDecoration(
            //   // color: Color.fromARGB(255, 235, 237, 237),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 237, 237),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor:
                      totalAmount == 0.0 ? 0.0 : (amount / totalAmount),
                  // alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            )),
        Text(day),
      ],
    );

    // return Column(
    //   children: [
    //     Text('\$$amount'),
    //     Text(
    //         '${totalAmount == 0.0 ? 0.0 : (amount / totalAmount).toStringAsFixed(1)}'),
    //     Text(day),
    //   ],
    // );
  } // build

*/


// daily-chart: no-stack; using fractionallysizedbox
/*
 // build

*/