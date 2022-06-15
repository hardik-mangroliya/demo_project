import 'package:demo_project/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'api_service.dart';
import 'detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'Demo Home Page'),
      routes: {
        PageRoutes.home: (context) => DetailsScreen(),
      },
    );
  }
}

class PageRoutes {
  static const String home = DetailsScreen.routeName;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  void _incrementCounter() async {
    await ApiService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(title: 'title');
  }
}
