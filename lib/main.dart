import 'package:flutter/material.dart';

import "package:local_market/views/login.dart";

void main() => runApp(
  new MaterialApp(

    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red.shade900
    ),
    //... changing home rout 
    home: Login()
  )
);