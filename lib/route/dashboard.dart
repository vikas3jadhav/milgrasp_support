import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milgrasp_support/data/MyColors.dart';
import 'package:milgrasp_support/data/img.dart';
import 'package:milgrasp_support/model/BottomNav.dart';
import 'package:milgrasp_support/route/completed_tickets.dart';
import 'package:milgrasp_support/route/my_tickets.dart';
import 'package:milgrasp_support/route/statistics.dart';
import 'package:milgrasp_support/widget/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'about.dart';
import 'login.dart';
import 'other_tickets.dart';

class Dashboard extends StatefulWidget {

  @override
    DashboardState createState() => new DashboardState();

}

class DashboardState extends State<Dashboard>{

  SharedPreferences logindata;
  String name,username,usertype,department,email,mobile,dob,gender,branch,user_pic;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext context;
  int currentIndex = 0;

  final widgetOptions = [
    new MyTickets(),
    new OtherTickets(),
    new CompletedTickets(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      name = logindata.getString('NAME');
      username = logindata.getString('USERNAME');
      usertype = logindata.getString('USERTYPE');
      department = logindata.getString('DEPARTMENT');
      email = logindata.getString('EMAIL');
      mobile = logindata.getString('MOBILE');
      dob = logindata.getString('DOB');
      gender = logindata.getString('GENDER');
      branch = logindata.getString('BRANCH');
      user_pic = logindata.getString('PIC');
    });
  }

//  void onDrawerItemClicked(String name) {
//    Navigator.pop(context);
//    Toast.show(name + " Selected", context);
//  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    Widget widget = Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: Text("Milgrasp Support",
            style: MyText.body2(context).copyWith(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Century Gothic')),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            if (scaffoldKey.currentState.isDrawerOpen) {
              scaffoldKey.currentState.openEndDrawer();
            } else {
              scaffoldKey.currentState.openDrawer();
            }
          },
        ),
      ),
      body: Scaffold(
        key: scaffoldKey,
        backgroundColor: MyColors.grey_90,
        drawer: Container(
          width: 200,
          child: Drawer(
            child: Container(
              color: Colors.black,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 20),
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                              NetworkImage("https://d255rstmahelrq.cloudfront.net/final/"+user_pic),
                            ),
                          ),
                          Container(height: 7),
                          Text(name,
                              style: MyText.body2(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Century Gothic')),
                          Container(height: 2),
                          Text(email,style: MyText.body2(context).copyWith(color: Colors.white,fontFamily: 'Century Gothic'))
                        ],
                      ),
                    ),

                    Container(height: 20),
                    Divider(
                    color: Colors.white),
                    Container(height: 20),
                    InkWell(onTap: (){

                    },
                      child: Container(height: 25, padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.domain, color: Colors.white, size: 20),
                            Container(width: 20),
                            Expanded(child: Text("Home", style: MyText.body2(context).copyWith(color: Colors.white,fontFamily: 'Century Gothic'))),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 10),
                    InkWell(onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Statistics()),
                      );
                    },
                      child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.data_usage, color: Colors.white, size: 20),
                            Container(width: 20),
                            Expanded(child: Text("Statistics", style: MyText.body2(context).copyWith(color: Colors.white,fontFamily: 'Century Gothic'))),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 10),
                    InkWell(onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      );
                    },
                      child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.info, color: Colors.white, size: 20),
                            Container(width: 20),
                            Expanded(child: Text("About Us", style: MyText.body2(context).copyWith(color: Colors.white,fontFamily: 'Century Gothic'))),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 10),
                    InkWell(onTap: (){
                      alertLogoutDialog(context);
                    },
                      child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.power_settings_new, color: Colors.white, size: 20),
                            Container(width: 20),
                            Expanded(child: Text("Logout", style: MyText.body2(context).copyWith(color: Colors.white,fontFamily: 'Century Gothic'))),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: widgetOptions.elementAt(currentIndex),
        ),

      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: MyColors.grey_60,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('My'),
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Text('Others'),
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.done),
          title: Text('Completed'),
        ),
]
      ),
    );

    return widget;
  }

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("NAME");
    prefs.remove("USERNAME");
    prefs.remove("DEPARTMENT");
    prefs.remove("USERTYPE");
    prefs.remove("EMAIL");
    prefs.remove("MOBILE");
    prefs.remove("DOB");
    prefs.remove("GENDER");
    prefs.remove("BRANCH");
    prefs.remove("ISLOGGEDIN");

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => Login()));
  }

  void alertLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure you want to logout ?"),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                logout();
              },
            )
          ],
        );
      },
    );
  }
}
