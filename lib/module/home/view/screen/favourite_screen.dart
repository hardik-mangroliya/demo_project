import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_detail_screen.dart';

class FavouriteScreen extends StatefulWidget {
  static const routeName = '/.main.dart';

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

// bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Padding(
            padding: EdgeInsets.only(left:40.0),
            child: Text('Favourite Screen',style: TextStyle(color: Colors.black),),
          ),
          
          backgroundColor: Colors.white,
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
                        isFav = homeScreenController.userlist[index].favourite == 0;
                        return isFav ? Column(
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
                                          onTap: () {
                                            setState(() {
                                              isFav = !isFav;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.star,
                                            color: 
                                                Colors.amber
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
                                    '${homeScreenController
                                                .userlist[index].firstName ??
                                            ''} ${homeScreenController
                                                .userlist[index].lastName ??
                                            ''}',
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
                        ) : Container();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        isFav = homeScreenController.userlist[index].favourite == 0;
                        return isFav ? Divider() : Container();
                      },
                    ),
        ));
  }
}
