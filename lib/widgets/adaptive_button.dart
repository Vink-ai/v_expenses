import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';


class AdaptiveButton extends StatelessWidget {

  final Function presentDatePick;

  AdaptiveButton(this.presentDatePick);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
      ? CupertinoButton(
          onPressed: presentDatePick,
          child: Text(
            'Choose Date',
            style: 
            TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      : FlatButton(
        textColor: Theme.of(context).primaryColor,
        onPressed: presentDatePick, 
        child: Text(
          'Choose Date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );      
  }
}