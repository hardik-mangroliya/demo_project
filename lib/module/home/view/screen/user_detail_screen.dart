// ignore_for_file: prefer_const_constructors

import 'package:demo_project/module/home/view/widget/comman_widget.dart';
import 'package:demo_project/module/home/view/widget/user_comman_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/home_screenController.dart';
import '../../controller/text_field_controller.dart';
import '../../model/user_model.dart';

class UserlistScreen extends StatefulWidget {
   UserlistScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<UserlistScreen> createState() => _UserlistScreenState();


}
  TextEditingController biocontroller = TextEditingController();
  TextFieldController textFieldController= Get.put(TextFieldController());
  HomeScreenController homeScreenController= Get.find();
  
  bool isFav=false;

class _UserlistScreenState extends State<UserlistScreen> {
  @override
  void initState() {
    super.initState();
    biocontroller.text= widget.user.bio ?? "";
    isFav=widget.user.favourite==0;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
        elevation: 0,
        actions: [
          IconButton(
            icon: InkWell(
              onTap: () {
                setState(() {
                  isFav = !isFav;
                });
              },
              child:  Icon(
                Icons.star,
                color: isFav ? Colors.amber:Colors.grey, 
                size: 30,
              ),
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6mU5mYYp5c00nAGXH3FPRlpSV2xXB9_P5gw&usqp=CAU"),
              // child:Text("AB"),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    // child: Text("First Name"),
                    child: UserCommanWidget(
                      title: "First Name",
                      value: widget.user.firstName ?? "",
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 90.0),
                    // child: Text("Last Name"),
                    child: UserCommanWidget(
                      title: "Last Name",
                      value: widget.user.lastName ?? "",
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    // child: Text("Email"),
                    child: UserCommanWidget(
                      title: "Email",
                      value: widget.user.email ?? "",
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Card(
              child: TextFormField(
                controller: biocontroller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Bio",
                    // labelStyle: "",
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide())),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 14),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: Center( 
                
                child: InkWell(
                  onTap: () async{
                   await textFieldController.insertdata(bio: biocontroller.text,id: widget.user.id.toString(), favourite: isFav ? 0 : 1);
                   homeScreenController.getUserFromAPI();
                  Navigator.pop(context);

                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
