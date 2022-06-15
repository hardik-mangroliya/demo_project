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

// class CommonWidgetColumn extends StatelessWidget {
//   CommonWidgetColumn({Key? key, required String text}) : super(key: key);
//   String text;

//   @override
//   Widget build(BuildContext context) {
//     // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: const [
    //     Padding(
    //       padding: EdgeInsets.all(8.0),
    //       child: Text(
    //         'No Internet',
    //         textScaleFactor: 2.0,
    //       ),
    //     ),
    //     Text(
    //       'Please Check Your Internet Connection!!',
    //       textAlign: TextAlign.center,
    //       textScaleFactor: 1.5,
    //     ),
    //   ],
    // );
//   }
// }
