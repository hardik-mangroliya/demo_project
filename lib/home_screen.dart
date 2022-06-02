// ignore_for_file: avoid_print

import 'package:demo_project/search_screen.dart';
import 'package:demo_project/user_listScreen.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            // 'Second Project',
            'Tap Here For Search =>'),
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
        backgroundColor: const Color.fromARGB(255, 27, 131, 173),
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
                // print("2");
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
      body: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 5,
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
