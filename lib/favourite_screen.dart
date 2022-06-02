import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  static const routeName = '/.main.dart';

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourite Screen'),
        ),
        // drawer: Drawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'This is Favourite Page!',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              FloatingActionButton(
                  child: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ));
  }
}
