// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_project/model/comman_widget.dart';
import 'package:demo_project/search_screen.dart';
import 'package:demo_project/user_listScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detail_screen.dart';
import 'drawer_list_tile.dart';
import 'favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      var developer;
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityResult = result;
      if (ConnectivityResult.none == result) {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                elevation: 100,
                child: ListView(shrinkWrap: true, children: <Widget>[
                  const SizedBox(height: 30),
                  const Icon(
                      Icons
                          .signal_wifi_statusbar_connected_no_internet_4_rounded,
                      size: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'No Internet',
                          textScaleFactor: 2.0,
                        ),
                      ),
                      Text(
                        'Please Check Your Internet Connection!!',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                      ),
                    ],
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: const [
                  //     CommonWidgetColumn(text: "No Internet"),
                  //     CommonWidgetColumn(
                  //         text: "Please Check Your Internet Cnnection")
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidgetButton(text: "OK", color: Colors.blue),
                      CommonWidgetButton(text: "RETRY", color: Colors.blue),
                    ],
                  ),
                ]),
              );
            });
        // );
      }
    });
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tap Here For Search =>'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              })
        ],
        backgroundColor: Color.fromARGB(255, 5, 77, 105),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                  child: Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6mU5mYYp5c00nAGXH3FPRlpSV2xXB9_P5gw&usqp=CAU",
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  const Text(
                    'Hardik Mangroliya',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'hadik.mangroliya@joflee.com',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )
                ],
              )),
            ),
            DrawerListTile(
              title: 'Dashboard',
              index: 1,
              icon: const Icon(Icons.home),
              onTap: () {
                print("1");
              },
            ),
            DrawerListTile(
              title: "Favorite",
              index: 2,
              icon: const Icon(Icons.star_border),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavouriteScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const UserListScreen()),
              ));
        },
        tooltip: 'increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
