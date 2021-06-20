import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonText;
  final Function buttonHandler;

  const AdaptiveFlatButton(this.buttonText, this.buttonHandler);
  @override
  Widget build(BuildContext context) {
    // we want to show cupetrino button
    return Platform.isAndroid
        ? CupertinoButton(
            onPressed: buttonHandler,
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            onPressed: buttonHandler,
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
