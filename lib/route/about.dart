import 'package:flutter/material.dart';
import 'package:milgrasp_support/data/MyColors.dart';
import 'package:milgrasp_support/data/MyStrings.dart';
import 'package:milgrasp_support/data/img.dart';
import 'package:milgrasp_support/widget/MyText.dart';

class About extends StatefulWidget{
  @override
    AboutState createState() => new AboutState();
  }

  class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "About Us",
            style: MyText.body2(context).copyWith(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Century Gothic'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Our Team",style: MyText.medium(context).copyWith(color: MyColors.grey_90,fontFamily: 'Century Gothic', fontWeight: FontWeight.w500)),
                Container(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(Img.get('photo_male_6.jpg')),
                          ),
                          Container(height: 8),
                          Text("Piyush Kamdar", style: MyText.caption(context).copyWith(color: MyColors.grey_90,fontFamily: 'Century Gothic', fontWeight: FontWeight.w600)),
                          Container(height: 4),
                          Text("Founder", style: MyText.caption(context).copyWith(color: MyColors.grey_60,fontFamily: 'Century Gothic', fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(Img.get('photo_male_6.jpg')),
                          ),
                          Container(height: 8),
                          Text("Mayur Tailor", style: MyText.caption(context).copyWith(color: MyColors.grey_90,fontFamily: 'Century Gothic', fontWeight: FontWeight.w600)),
                          Container(height: 4),
                          Text("CEO", style: MyText.caption(context).copyWith(color: MyColors.grey_60,fontFamily: 'Century Gothic', fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(height: 25),
                Text("Mission", style: MyText.medium(context).copyWith(color: MyColors.grey_90,fontFamily: 'Century Gothic', fontWeight: FontWeight.w500)),
                Container(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(MyStrings.mission, textAlign : TextAlign.justify, style: MyText.body2(context).copyWith(
                    color: MyColors.grey_60,fontFamily: 'Century Gothic', fontWeight: FontWeight.w300,
                  )),
                ),

                Container(height: 25),
                Text("Address", style: MyText.medium(context).copyWith(color: MyColors.grey_90,fontFamily: 'Century Gothic', fontWeight: FontWeight.w500)),
                Container(height: 15),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(Img.get('image_maps.jpg'), height: 150, width: double.infinity, fit: BoxFit.cover),
                      Container(height: 15),
                      Text("B/10, 3rd Floor, Ratandeep Cosmopolitan Society,", style: MyText.subhead(context).copyWith(color: MyColors.grey_60,fontFamily: 'Century Gothic')),
                      Text("SV Rd, opp. HDFC Bank, Before Shoppers Stop, Andheri West,", style: MyText.subhead(context).copyWith(color: MyColors.grey_60,fontFamily: 'Century Gothic')),
                      Text("Mumbai, Maharashtra 400058", style: MyText.subhead(context).copyWith(color: MyColors.grey_60,fontFamily: 'Century Gothic')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

}