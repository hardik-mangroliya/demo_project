// ignore_for_file: avoid_print, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_project/module/home/view/widget/comman_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/home_screenController.dart';
import '../../model/drawer_list_tile.dart';
import 'favourite_screen.dart';
import '../../../../core/dbHelper.dart';
import 'user_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbhelper = DatabaseHelper();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    initConnectivity();
    homeScreenController.getUserFromAPI();

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
                          .wifi_off_sharp,color: Colors.blue,
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
          toolbarHeight: 70,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(bottom:2.0),
            child: Container(
              decoration: BoxDecoration(
              color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 9,spreadRadius: 0.5,color: Colors.black),],
                borderRadius: BorderRadius.circular(22)
              ),
              child:  Padding(
                padding: const EdgeInsets.fromLTRB(10,0,5,0),
                child: TextField(
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    homeScreenController.SearchUser(value);
                  },
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search,color: Colors.black,),
                    hintText: "Search",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    
                  ),

                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(50),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
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
                  Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Favorite",
                icon: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouriteScreen(),
                      ));
                },
              ),
              const Spacer(),
               Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context, 
                      builder: (ctx)=>AlertDialog(
                        title: Text("Alert Box"),
                        // content: Text("If You Want To Clear All Data Permently???"),
                        content: Text("Are you sure,You want to clear all data!!"),
                        actions: [
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("Cancel"),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: (){
                              dbhelper.delete();
                              homeScreenController.userlist.clear();
                              Navigator.pop(context);
                              setState(() {});
                            }, 
                              child: const Text("Okay",style: TextStyle(color: Colors.white),)),
                          ),
                        ],
                        ));
                  },
                  child: const Text("Clear data",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          decoration: TextDecoration.underline)),
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => homeScreenController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : homeScreenController.userlist.isEmpty
                  ? const Center(
                      child: Text("No Data Found"),
                    )
                  : ListView.separated(
                      itemCount: homeScreenController.userlist.length,
                      itemBuilder: (context, index) {
                        final isFav = homeScreenController.userlist[index].favourite==0;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: ListTile(
                                  trailing: Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Builder(builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return InkWell(
                                          child: Icon(
                                            Icons.star,
                                            color: isFav ? Colors.amber : Colors.grey
                                          ),
                                        );
                                      });
                                    }),
                                  ),
                                  leading: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserlistScreen(
                                                    user: homeScreenController
                                                        .userlist[index],
                                                  )));
                                    },
                                    child: const CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6mU5mYYp5c00nAGXH3FPRlpSV2xXB9_P5gw&usqp=CAU"),
                                    ),
                                  ),
                                  title: Text(
                                    (homeScreenController
                                                .userlist[index].firstName ??
                                            '') +
                                        ' ' +
                                        (homeScreenController
                                                .userlist[index].lastName ??
                                            ''),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(homeScreenController
                                          .userlist[index].email ??
                                      ""),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
        ));
  }
}
