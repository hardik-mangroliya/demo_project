import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTap})
      : super(key: key);
  final String title;
  final Widget icon;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text("${title} "),
      onTap: onTap,
    );
  }
}
