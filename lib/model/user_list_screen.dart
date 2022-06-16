// ignore_for_file: prefer_const_constructors

import 'package:demo_project/model/comman_widget.dart';
import 'package:demo_project/model/user_comman_widget.dart';
import 'package:demo_project/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserlistScreen extends StatefulWidget {
  const UserlistScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<UserlistScreen> createState() => _UserlistScreenState();
  // _userlistScreenState createState()=> _userlistScreenState
}

class _UserlistScreenState extends State<UserlistScreen> {
  late final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // iconTheme: const IconTheme(color: Colors.amber),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.star_border,
              color: Colors.amber,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.black,
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
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text("First Name"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Dev",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 90.0),
                    child: Text("Last Name"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 90.0),
                    child: Text(
                      "Patel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
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
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text("Email"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Devpatel123@gmail.com",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Bio",
                    // fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide: BorderSide())),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.pink,
    );
  }
}
