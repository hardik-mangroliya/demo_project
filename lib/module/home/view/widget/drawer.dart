



import 'package:demo_project/module/home/model/drawer_list_tile.dart';
import 'package:demo_project/module/home/view/screen/favourite_screen.dart';
import 'package:demo_project/module/home/view/screen/user_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
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
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouriteScreen(),
                        ));
                  },
                ),
                 Padding(
                  padding: EdgeInsets.only(bottom: 40,top: 300),
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context, 
                        builder: (ctx)=>AlertDialog(
                          title: Text("Alert Box"),
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
                                homeScreenController.searchController.clear();
                                Navigator.pop(context);                                
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
        );
  }
}







