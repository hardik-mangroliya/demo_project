// ignore_for_file: avoid_print, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_project/model/comman_widget.dart';
import 'package:demo_project/model/showData_fromSqlite.dart';
import 'package:demo_project/search_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'drawer_list_tile.dart';
import 'favourite_screen.dart';
import 'model/sqLite_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbhelper = ToDoHelper();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    initConnectivity();
    homeScreenController.getUserData();

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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );
                })
          ],
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                // color: Theme.of(context).primaryColor,
                color: Colors.white,
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // image: DecorationImage(
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6mU5mYYp5c00nAGXH3FPRlpSV2xXB9_P5gw&usqp=CAU",
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                )),
              ),
              DrawerListTile(
                title: 'Home',
                icon: const Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(
                          title: 'HomeScreen',
                        ),
                      ));
                },
              ),
              DrawerListTile(
                title: "Favorite",
                icon: const Icon(Icons.star_border),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouriteScreen(),
                      ));
                },
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text("Clear data",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ),
        body: Obx(
          () => ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          (homeScreenController.listOfUser![index].firstName ??
                                  '') +
                              ' ' +
                              (homeScreenController
                                      .listOfUser![index].lastName ??
                                  ''),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            homeScreenController.listOfUser![index].email ??
                                ""),
                        trailing: const Icon(Icons.star_border_outlined),
                        leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6mU5mYYp5c00nAGXH3FPRlpSV2xXB9_P5gw&usqp=CAU")),
                      ),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: homeScreenController.listOfUser?.length ?? 0,
          ),
        ));
  }
}
