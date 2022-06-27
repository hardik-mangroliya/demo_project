import 'package:demo_project/module/home/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/dbHelper.dart';
import 'user_detail_screen.dart';

class FavouriteScreen extends StatefulWidget {
  
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}
 final dbhelper = DatabaseHelper();
Future favouriteUser() async{
  final users=dbhelper.favourite();
}



class _FavouriteScreenState extends State<FavouriteScreen> {

@override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Padding(
            padding: EdgeInsets.only(left:40.0),
            child: Text('Favourite Screen',style: TextStyle(color: Colors.black),),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<User>>(
          future: dbhelper.favourite(),
          builder: (BuildContext context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            } 
            List<User> userList=snapshot.data ?? [];
            return Padding(padding: EdgeInsets.all(8),
            child: userList.isEmpty ? Center(child: Text(("NO USER FOUND")),)
                      : ListView.separated(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                        bool isFavorite = userList[index].favourite == 0 || userList[index].favourite != null  ? true : false;
                            return  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                   var response =  await Navigator.push<bool>(context, MaterialPageRoute(builder: (context)=> UserlistScreen(user: userList[index])));
                                   if(response ?? false){
                                    setState(() {});
                                     Navigator.pop(context,true);

                                   }
                                  },
                                  child: Container( 
                                    height: 90,
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8, right: 8),
                                      child: ListTile(
                                        trailing: Padding(
                                          padding: EdgeInsets.only(left: 8, right: 8),
                                          child: 
                                               Icon(
                                                Icons.star,
                                                color:isFavorite ? 
                                                // userList[index].favourite?? false ? 
                                                    Colors.amber:Colors.grey,
                                              ),                               
                                        ),
                                        leading: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserlistScreen(
                                                          user: userList[index],
                                                        )));
                                          },
                                          child: const CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6mU5mYYp5c00nAGXH3FPRlpSV2xXB9_P5gw&usqp=CAU"),
                                          ),
                                        ),
                                        title: Text(
                                          '${userList[index].firstName ??
                                                  ''} ${userList[index].lastName ??
                                                  ''}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(userList[index].email ??
                                            "",
                                            maxLines: 1,),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return  const Divider() ;
                          },)
         ); },) ,);
          }
      
      
  }



