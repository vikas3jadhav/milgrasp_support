import 'dart:async';

import 'package:flutter/material.dart';
import 'package:milgrasp_support/Utils/SessionManagement.dart';
import 'package:milgrasp_support/data/MyColors.dart';
import 'package:milgrasp_support/route/dashboard.dart';
import 'package:milgrasp_support/widget/MyText.dart';
import 'package:milgrasp_support/route/login.dart';

import 'data/img.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        primaryColorDark: MyColors.primaryDark,
        primaryColorLight: MyColors.primaryLight,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent)),
    home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
      }
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigationPage);
  }

  void navigationPage()async {
    final isLoggedIn = await SessionManagement.getUserLoggedInSharedPreference() ?? false;

    if(isLoggedIn){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Image.asset(Img.get('qrt.png'),fit: BoxFit.cover),
              ),
              Container(height: 10),

//              Text("Milgrasp",
//                style: MyText.headline(context).copyWith(color: Colors.white,fontSize: 20),
//              ),

              Container(height: 20),

              Container(height: 5, width: 100,
              child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.primaryLight),
              backgroundColor: Colors.grey[300],
              ),
              ),

              Container(height: 30),

              Text("© Milgrasp 2016",
                style: MyText.headline(context).copyWith(color: Colors.white,fontSize: 13,fontFamily: 'Century Gothic'),
              ),


            ],
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
