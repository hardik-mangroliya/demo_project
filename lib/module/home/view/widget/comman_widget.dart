// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CommonWidgetButton extends StatelessWidget {
  CommonWidgetButton({Key? key, required this.text, required this.color})
      : super(key: key);
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.all(10),
        height: 50,
        // width: 125,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(color: Colors.blue)),
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: Colors.white,
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
          color: color,
        ),
      ),
    );
  }
}
