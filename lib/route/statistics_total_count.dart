import 'package:flutter/material.dart';
import 'package:milgrasp_support/Utils/ApiManager.dart';
import 'package:milgrasp_support/data/MyColors.dart';
import 'package:milgrasp_support/model/TodaysCount.dart';
import 'package:milgrasp_support/widget/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsTotalCount extends StatefulWidget{

  @override
  StatisticsTotalCountState createState() => new StatisticsTotalCountState();
}

class StatisticsTotalCountState extends State<StatisticsTotalCount>{
  List<TodaysCount> todaysData = new List<TodaysCount>();
  int count = 0;
  SharedPreferences logindata;
  String name,
      username,
      usertype,
      department,
      email,
      mobile,
      dob,
      gender,
      branch,
      user_pic;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
    callAPI();
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: MyColors.grey_20, body: getMyTicketList());
  }

  Widget getMyTicketList() {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = ( _screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var cellHeight = 60;
    var _aspectRatio = _width /cellHeight;

    return Container(
        padding: EdgeInsets.all(16.0),

        child: GridView.builder(
            itemCount: this.todaysData == null ? 0 : this.todaysData.length,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _crossAxisCount,childAspectRatio: _aspectRatio),
            itemBuilder: (context, item) {
              var count = todaysData[item].count;
              var attended_by = todaysData[item].attended_by;
              return Container(
                  child:Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    //    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    elevation: 3.0,
                    color: selectedColour(item),
                    child: Column(
                      children: [
                        Container(height: 8),
                        Text(count,
                            style: MyText.caption(context).copyWith(
                                color: Colors.white,
                                fontFamily: 'Century Gothic')),
                        Container(height: 4),
                        Text(attended_by,
                            style: MyText.caption(context).copyWith(
                                color: Colors.white,
                                fontFamily: 'Century Gothic')),
                      ],
                    ),
                  ));
            }));


  }
  callAPI() async {
    var body = {
      "requestfrom": "mobile",
    };

    final res = await ApiManager().post("Web/get_mis_attended_by_count", body);

    setState(() {
      //    this.ticketData = res;
      res["status_with_count"].forEach((data) => {
        this.todaysData.add(TodaysCount.fromJSON(data)),
      });
    });
  }

  Color selectedColour(int position) {
    Color c;
    if (position % 7 == 0) c = Colors.red;
    if (position % 7 == 1) c = Colors.purple;
    if (position % 7 == 2) c = Colors.black;
    if (position % 7 == 3) c = Colors.deepOrangeAccent;
    if (position % 7 == 4) c = Colors.blue;
    if (position % 7 == 5) c = Colors.brown;
    if (position % 7 == 6) c = Colors.teal;

    return c;
  }

}