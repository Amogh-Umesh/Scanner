import 'package:flutter/material.dart';
import 'package:scanner_app/pages/home.dart';
import 'package:scanner_app/pages/settings.dart';
import 'package:scanner_app/pages/cam.dart';
import 'package:scanner_app/pages/loading.dart';
import 'package:scanner_app/globals/globals.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context)=> const Loading(),
      //'/settings': (context) => ,
      '/home': (context) =>  const Home(),
      '/camera': (context) =>  const Camera(),
    },
    theme: ThemeData(
      primaryColor: Colors.green[500],
      ),
    ),
);
