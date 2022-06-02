import 'package:demo_project/api_service.dart';
import 'package:demo_project/detail_screen.dart';
import 'package:demo_project/home_screen.dart';
import 'package:demo_project/user_listScreen.dart';
import 'package:flutter/material.dart';

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
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
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
    await ApiService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(title: 'title');
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const UserListScreen(),
//             ),
//           );
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


















// +++++++++++++++++++++++++++++++++++++++++++
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePage extends State<HomePage> {
//   void _incremanetCounter() async {
//     await ApiService().getUser();
//   }

//   @override
//   Widegt build(BuildContext context){
    
//   }
// }
