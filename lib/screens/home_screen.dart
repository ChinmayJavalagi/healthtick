import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthtick/screens/page0.dart';
import 'package:healthtick/screens/page1.dart';
import 'package:healthtick/screens/page2.dart';
import 'package:healthtick/screens/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController();
  int currentPage = 0;

  void setPage(int page) {
    setState(() {
      currentPage = page;
      controller.animateToPage(
        page,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff110019),
      appBar: AppBar(
        title: Text('Mindfull Meal timer', style: TextStyle(fontFamily: "DMSans"),),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                controller: controller,
                count: 4,
                effect: JumpingDotEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.blueGrey[300]!,
                  dotHeight: 20,
                  dotWidth: 20,
                  spacing: 16,
                  //verticalOffset: 50,
                  jumpScale: 3,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: PageView(
                  controller: controller,
                  onPageChanged: (int page){
                    setState(() {
                      currentPage = page;
                    });
                  },
                  children: [
                    Page0(onPageSelected: setPage,),
                    Page1(onPageSelected: setPage),
                    Page2(onPageSelected: setPage),
                    Page3(onPageSelected: setPage,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

