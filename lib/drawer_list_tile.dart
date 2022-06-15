import 'package:flutter/material.dart';

import 'detail_screen.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      required this.title,
      // required this.index,
      required this.icon,
      required this.onTap})
      : super(key: key);
  final String title;
  // final int index;
  final Widget icon;
  // final void Function() onTap;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text("${title} "),
      onTap: onTap,
    );
  }
}
