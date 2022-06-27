// ignore_for_file: avoid_print, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_project/module/home/model/user_model.dart';
import 'package:demo_project/module/home/view/widget/comman_widget.dart';
import 'package:demo_project/module/home/view/widget/drawer.dart';
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
    }
    );
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
                boxShadow: [BoxShadow(blurRadius: 10,spreadRadius: 5,color: Colors.black12),],
                borderRadius: BorderRadius.circular(22)
              ),
              child:  Padding(
                padding: const EdgeInsets.fromLTRB(10,0,5,0),
                child: TextFormField(
                  controller: homeScreenController.searchController,
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
        drawer: MyDrawer(),
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
                        String firstName=homeScreenController
                                                .userlist[index].firstName ??
                                            '';
                        String lastName=homeScreenController.userlist[index].lastName ?? '';
                        final isFav = homeScreenController.userlist[index].favourite==0;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> UserlistScreen(user: homeScreenController.userlist[index])));
                              },
                              child: Container(
                                height: 90,
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: ListTile(
                                     title: Text(
                                      (firstName) +
                                          ' ' +
                                          (lastName),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(homeScreenController
                                            .userlist[index].email ??
                                        "",
                                        maxLines: 1,),
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
                                    leading: CircleAvatar(
                                      radius: 25,
                                      child: Text('${firstName[0]} ${lastName[0]}'),
                                    ),
                                ),
                              )
                                                      ),
                            )],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
        ));
  }
}
