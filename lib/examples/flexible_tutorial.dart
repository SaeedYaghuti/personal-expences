import 'package:flutter/material.dart';

class FlexibleTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              height: 150,
              color: Colors.amber,
              child: const Text('Item 1 is too big Yes is too big'),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              height: 150,
              color: Colors.blueGrey,
              child: const Text('Item 2'),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
              height: 150,
              color: Colors.cyan,
              child: const Text('Item 3'),
            ),
          ),
        ],
      ),
    );
  }
}
