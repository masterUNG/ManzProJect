import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/states/authen.dart';
import 'package:myproject/states/my_home_page.dart';

import 'mylocation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Authen(
       
      ),
    );
  }
}
