// import 'package:flutter/material.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthtick/screens/home_screen.dart';
import 'package:healthtick/screens/page0.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HealthTick",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DMSans',
        appBarTheme: AppBarTheme(
            color: Color(0xff110019)
        ),
        primaryColor: Color(0xff110019),
      ),
      home: HomeScreen(),
    );
  }
}
