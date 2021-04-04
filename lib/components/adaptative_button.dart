import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(this.label),
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            onPressed: null,
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(this.label),
          );
  }
}
