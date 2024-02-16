import 'package:flutter/material.dart';

@immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {super.key,
      required this.title,
      required this.appBarOnPressed,
      this.hasBack = true,
      this.center = false,
      this.actions});
  String title;
  Function()? appBarOnPressed;
  List<Widget>? actions;
  bool? hasBack = true;
  bool? center = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: (center == false) ? false : true,
      leading: (hasBack == true)
          ? IconButton(
              onPressed: appBarOnPressed,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))
          : null,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
      ),
      actions: actions,
    );
  }
}
