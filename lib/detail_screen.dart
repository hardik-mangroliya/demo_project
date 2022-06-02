import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/.main.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen'),
        ),
        drawer: Drawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'This is Detail Page!',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ));
  }
}
