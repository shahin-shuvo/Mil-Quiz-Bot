import 'package:flutter/material.dart';
import 'package:mil_quiz_bot/offrs_ques.dart';
import 'package:mil_quiz_bot/jco_ques.dart';
import 'package:mil_quiz_bot/nco_ques.dart';
import 'package:mil_quiz_bot/quiz.dart';
import 'package:mil_quiz_bot/prac_abbr.dart';
import 'package:mil_quiz_bot/CustomAppBar.dart';

class LandingPage extends StatefulWidget {


  final int initNavIndex;
  const LandingPage({super.key, required this.initNavIndex});



  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int navIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navIndex= widget.initNavIndex;

  }

  final screens = [
    OffrsQues(),
    JCOQues(),
    NCOQues(),
    Quiz()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomBar(barName: "MIL QUIZ BOT",),
      ),
      body: screens[navIndex],
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.white,
            // backgroundColor: Color(0xff145A32),
            backgroundColor: Color(0xffCACFD2),
          ),
          child: NavigationBar(

            height: 70,
            selectedIndex: navIndex,
            onDestinationSelected: (navIndex) =>
                setState(() => this.navIndex = navIndex),
            destinations: [
              NavigationDestination(icon: const ImageIcon(
                  AssetImage('assets/images/offr.png')), label: 'OFFRS', ),
              NavigationDestination(icon: const ImageIcon(
                  AssetImage('assets/images/jco.png')), label: 'JCO'),
              NavigationDestination(icon: const ImageIcon(
                  AssetImage('assets/images/nco.png')), label: 'NCO'),

              NavigationDestination(icon: Icon(Icons.menu_book), label: 'QUIZ'),

            ],
          )
      ),
    );

  }
}

class CustomBar extends StatelessWidget{
  final String barName;

  const CustomBar({super.key, required this.barName});
  @override
  Widget build(BuildContext context) {
    return  Material(
        color: Colors.transparent,
        child: ClipPath(
          clipper: CustomAppBar(),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage( image: AssetImage("assets/images/appbar_bg.jpeg"), fit: BoxFit.cover, )
            ),
            child: Column( mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
              Text(barName , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
            ],),
          ),

        ),
      );


    throw UnimplementedError();
  }
}

class NavBottom extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
    throw UnimplementedError();
  }

}