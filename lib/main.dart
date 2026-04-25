import 'package:contactapp/provider/contacts_proivder.dart';
import 'package:contactapp/screens/homepage_basic.dart';
import 'package:contactapp/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false, 
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.purple,

      ),
      home: Homepage2() ,
    );
  }
}
