import 'package:flutter/material.dart';
import 'package:milgrasp_support/Utils/ApiManager.dart';
import 'package:milgrasp_support/data/MyColors.dart';
import 'package:milgrasp_support/model/TodaysCount.dart';
import 'package:milgrasp_support/widget/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPriorityCount extends StatefulWidget{

  @override
  StatisticsPriorityCountState createState() => new StatisticsPriorityCountState();
}

class StatisticsPriorityCountState extends State<StatisticsPriorityCount>{
  List<PriorityCount> priorityData = new List<PriorityCount>();
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
            itemCount: this.priorityData == null ? 0 : this.priorityData.length,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _crossAxisCount,childAspectRatio: _aspectRatio),
            itemBuilder: (context, item) {
              var count = priorityData[item].count == null
                  ? "N/A"
                  : priorityData[item].count;
              var attended_by = priorityData[item].priority == null
                  ? "N/A"
                  : priorityData[item].priority;
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

    final res = await ApiManager().post("Support/getSupportTicketPriorityWiseCount", body);

    setState(() {
      //    this.ticketData = res;
      res["priority_count"].forEach((data) => {
        this.priorityData.add(PriorityCount.fromJSON(data)),
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

class PriorityCount{
  String priority;
  String count;

  PriorityCount(this.priority, this.count);


  PriorityCount.fromJSON(Map<String, dynamic> json) {
    priority =json["priority"];
    count =json["count"];
  }
}