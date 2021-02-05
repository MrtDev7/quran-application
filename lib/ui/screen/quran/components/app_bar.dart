import 'package:flutter/material.dart';

Widget quranListAppBar() {
  return AppBar(
    elevation: 0,
    title: Text(
      'الرئيسية',
      style: TextStyle(
        fontSize: 17,
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
