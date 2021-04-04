import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onSubmitted;

  AdaptativeTextField({
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: this.controller,
              keyboardType: this.keyboardType,
              onSubmitted: this.onSubmitted,
              placeholder: this.label,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: this.controller,
            keyboardType: this.keyboardType,
            onSubmitted: this.onSubmitted,
            decoration: InputDecoration(labelText: this.label),
          );
  }
}
