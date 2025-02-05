
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mil_quiz_bot/landing_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const LandingPage(initNavIndex: 0,)
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
           SingleChildScrollView(
             child: Container(
               height: MediaQuery.of(context).size.height,
                width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/milbg-3.png"), fit: BoxFit.cover,
                  )
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[

                    Card( // with Card
                      elevation: 30.0,
                      shape: CircleBorder(),

                      clipBehavior: Clip.antiAlias, // with Card
                      child: Image(image: AssetImage("assets/images/logo_army.png"), width: 80,),
                    ),

                    SizedBox(height: 20,),
                    Text("In War, In Peace,\n We are everywhere for our nation", textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 400,),
                    Image(image: AssetImage("assets/images/splash_lower_1.jpg"),
                        alignment: Alignment.bottomCenter),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff145A32 ),
                          Color(0xff85C1E9),
                        ]),
                      ),
                      child:
                      Text("Developed by Capt Shahin",
                        style:GoogleFonts.anton(fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],

                ),
              ),
           ),
    );
  }
}

