import 'package:flutter/material.dart';
import 'package:smart_healthcare/splash_screen_view.dart';


void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFEF5350),
          scaffoldBackgroundColor: const Color(0xFFEBE3E3),
        ),
        title: 'My app', // used by the OS task switcher
        home: SplashScreenView()),
  );
}


