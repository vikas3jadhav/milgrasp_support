import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:milgrasp_support/Utils/ApiManager.dart';
import 'package:milgrasp_support/data/MyColors.dart';
import 'package:milgrasp_support/data/MyStrings.dart';
import 'package:milgrasp_support/data/img.dart';
import 'package:milgrasp_support/model/SupportTicket.dart';
import 'package:milgrasp_support/widget/MyText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ribbon/ribbon.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class OtherTickets extends StatefulWidget {
  @override
  OtherTicketsState createState() => new OtherTicketsState();
}

class OtherTicketsState extends State<OtherTickets> {
  int count = 0;
  bool _visible = false;
  TextEditingController controller = new TextEditingController();

  GlobalKey<RefreshIndicatorState> refreshKey;

  //var ticketData;
  List<SupportTicket> ticketData = new List<SupportTicket>();

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
    refreshKey = GlobalKey<RefreshIndicatorState>();
    checkInternetConnectivity();
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
    return Column(children: <Widget>[
      new Container(
        height: 70.0,
        color: MyColors.grey_20,
        child: new Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Card(
            child: new ListTile(
              leading: new Icon(Icons.search),
              title: new TextField(
                controller: controller,
                decoration: new InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                onChanged: onSearchTextChanged,
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  controller.clear();
                  onSearchTextChanged('');
                },
              ),
            ),
          ),
        ),
      ),
      new Expanded(
          child: RefreshIndicator(
              key: refreshKey,
              onRefresh: () async {
                await callAPI("");
              },
              child: ListView.builder(
                  itemCount:
                  this.ticketData == null ? 0 : this.ticketData.length,
                  itemBuilder: (context, item) {
                    var fromuser = ticketData[item].fromuser == null
                        ? "N/A"
                        : ticketData[item].fromuser;
                    var fromuserdesignation =
                    ticketData[item].fromuserdesignation == null
                        ? ""
                        : ticketData[item].fromuserdesignation;
                    var fromuserpic = ticketData[item].fromuserpic == null
                        ? "Upload/profilepics/default.png"
                        : ticketData[item].fromuserpic;

                    var assignedusername =
                    ticketData[item].assignedusername == null
                        ? "N/A"
                        : ticketData[item].assignedusername;
                    var milearth_employee_designation =
                    ticketData[item].milearth_employee_designation == null
                        ? ""
                        : ticketData[item].milearth_employee_designation;
                    var milearth_employee_pic =
                    ticketData[item].milearth_employee_pic == null
                        ? "Upload/profilepics/default.png"
                        : ticketData[item].milearth_employee_pic;

                    var title = ticketData[item].title == null
                        ? "N/A"
                        : ticketData[item].title;
                    var usertype = ticketData[item].usertype == null
                        ? "N/A"
                        : ticketData[item].usertype;
                    var subdomain = ticketData[item].subdomain == null
                        ? "N/A"
                        : ticketData[item].subdomain;
                    var description = ticketData[item].description == null
                        ? "N/A"
                        : ticketData[item].description;
                    var status = ticketData[item].status == null
                        ? "N/A"
                        : ticketData[item].status;
                    var priority = ticketData[item].priority == null
                        ? "N/A"
                        : ticketData[item].priority;
                    var platform = ticketData[item].platform == null
                        ? "N/A"
                        : ticketData[item].platform;
                    var feature = ticketData[item].feature == null
                        ? "N/A"
                        : ticketData[item].feature;
                    var model = ticketData[item].androidmodel == null
                        ? "N/A"
                        : ticketData[item].androidmodel;
                    var device = ticketData[item].androiddevice == null
                        ? "N/A"
                        : ticketData[item].androiddevice;
                    var version = ticketData[item].androidversion == null
                        ? "N/A"
                        : ticketData[item].androidversion;
                    var mobile = ticketData[item].mobile == null
                        ? "N/A"
                        : ticketData[item].mobile;
                    var email = ticketData[item].fromuseremail == null
                        ? "N/A"
                        : ticketData[item].fromuseremail;
                    var datetime = ticketData[item].datetime == null
                        ? "N/A"
                        : ticketData[item].datetime;

                    var domain = subdomain.split(".");
                    var domain1 = domain[0];
                    String new_domain = "";
                    if (domain1.contains("https://")) {
                      new_domain = domain1.replaceAll("https://", "");
                    } else if (domain1.contains("http://")) {
                      new_domain = domain1.replaceAll("http://", "");
                    }

                    Color header_color;
                    if (usertype == "Parent" || usertype == "Student") {
                      header_color = MyColors.accent;
                    } else {
                      header_color = MyColors.primaryDark;
                    }

                    return ticketData.isNotEmpty
                        ? InkWell(
                        onTap: () {
                          setState(() {
                            _visible = !_visible;
                            ticketData[item];
                          });
                        },
                        child: new Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            color: Colors.white,
                            elevation: 2.0,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                                  width: double.infinity,
                                  height: 30,
                                  color: header_color,
                                  child: Text(new_domain,
                                      style: MyText.title(context).copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Century Gothic')),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(height: 15),
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "https://d255rstmahelrq.cloudfront.net/final/" +
                                                    fromuserpic),
                                            //AssetImage(Img.get('photo_male_6.jpg')),
                                          ),
                                          Container(height: 8),
                                          Text(fromuser,
                                              style: MyText.caption(context)
                                                  .copyWith(
                                                  color:
                                                  MyColors.grey_90,
                                                  fontFamily:
                                                  'Century Gothic',
                                                  fontWeight:
                                                  FontWeight.w600)),
                                          Container(height: 4),
                                          Text(fromuserdesignation,
                                              style: MyText.caption(context)
                                                  .copyWith(
                                                  color:
                                                  MyColors.grey_60,
                                                  fontFamily:
                                                  'Century Gothic',
                                                  fontWeight:
                                                  FontWeight.w400)),
                                        ],
                                      ),
                                    ),
                                    Image.asset(Img.get('arrow_fb.png'),
                                        width: 35,
                                        height: 35,
                                        fit: BoxFit.fill),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(height: 15),
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                            // AssetImage(Img.get('photo_male_6.jpg')),
                                            NetworkImage(
                                                "https://d255rstmahelrq.cloudfront.net/final/" +
                                                    milearth_employee_pic),
                                          ),
                                          Container(height: 8),
                                          Text(assignedusername,
                                              style: MyText.caption(context)
                                                  .copyWith(
                                                  color:
                                                  MyColors.grey_90,
                                                  fontFamily:
                                                  'Century Gothic',
                                                  fontWeight:
                                                  FontWeight.w600)),
                                          Container(height: 4),
                                          Text(
                                              milearth_employee_designation,
                                              style: MyText.caption(context)
                                                  .copyWith(
                                                  color:
                                                  MyColors.grey_60,
                                                  fontFamily:
                                                  'Century Gothic',
                                                  fontWeight:
                                                  FontWeight.w400)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(height: 5),
                                Container(width: 15),
                                Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    color: Colors.black,
                                    elevation: 2.0,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10, 5, 10, 5),
                                        child: Text(
                                          title,
                                          style: MyText.caption(context)
                                              .copyWith(
                                              color: Colors.white,
                                              fontFamily:
                                              'Century Gothic',
                                              fontWeight:
                                              FontWeight.w400),
                                        ))),
                                Container(width: 15),
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: Text(
                                          description,
                                          style: MyText.caption(context)
                                              .copyWith(
                                              color: Colors.black87,
                                              fontFamily:
                                              'Century Gothic',
                                              fontWeight:
                                              FontWeight.w400),
                                        ))),
                                Container(height: 5),
                                Row(
                                  children: [
                                    Container(width: 15),
                                    Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                              BorderRadius.circular(15.0)),
                                          child: Text(
                                            platform,
                                            style: MyText.body2(context)
                                                .copyWith(
                                                color: Colors.white,
                                                fontFamily:
                                                'Century Gothic'),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    Container(width: 15),
                                    Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                              BorderRadius.circular(15.0)),
                                          child: Text(
                                            feature,
                                            style: MyText.body2(context)
                                                .copyWith(
                                                color: Colors.white,
                                                fontFamily:
                                                'Century Gothic'),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    Container(width: 15),
                                    Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                              BorderRadius.circular(15.0)),
                                          child: Text(
                                            priority,
                                            style: MyText.body2(context)
                                                .copyWith(
                                                color: Colors.white,
                                                fontFamily:
                                                'Century Gothic'),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    Container(width: 15),
                                  ],
                                ),
                                Container(height: 10),
                                Divider(color: Colors.grey),
                                Visibility(
                                    visible: _visible,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(width: 15),
                                            Expanded(
                                              child: Text(
                                                  "Status : " + status,
                                                  style: MyText
                                                      .caption(context)
                                                      .copyWith(
                                                      color: MyColors
                                                          .grey_90,
                                                      fontFamily:
                                                      'Century Gothic',
                                                      fontWeight:
                                                      FontWeight
                                                          .w600)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  "Model : " + model,
                                                  style: MyText.caption(
                                                      context)
                                                      .copyWith(
                                                      color: MyColors
                                                          .grey_90,
                                                      fontFamily:
                                                      'Century Gothic',
                                                      fontWeight:
                                                      FontWeight
                                                          .w600)),
                                            )
                                          ],
                                        ),
                                        Container(height: 5),
                                        Divider(color: Colors.grey),
                                        Container(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(width: 15),
                                            Expanded(
                                              child: Text(
                                                  "Device : " + device,
                                                  style: MyText
                                                      .caption(context)
                                                      .copyWith(
                                                      color: MyColors
                                                          .grey_90,
                                                      fontFamily:
                                                      'Century Gothic',
                                                      fontWeight:
                                                      FontWeight
                                                          .w600)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  "Version : " + version,
                                                  style: MyText.caption(
                                                      context)
                                                      .copyWith(
                                                      color: MyColors
                                                          .grey_90,
                                                      fontFamily:
                                                      'Century Gothic',
                                                      fontWeight:
                                                      FontWeight
                                                          .w600)),
                                            )
                                          ],
                                        ),
                                        Container(height: 7),
                                        Divider(color: Colors.grey),
                                      ],
                                    )),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          if(mobile != "N/A") {
                                            UrlLauncher.launch('tel:${mobile}');
                                          }else{
                                            Toast.show("Mobile number not found", context);
                                          }
                                        },
                                        child: Image.asset(
                                            Img.get('phonecall.png'),
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.fill)),
                                    GestureDetector(
                                        onTap: () {
                                          UrlLauncher.launch(
                                              "https://wa.me/+91${mobile}?text=Dear ${fromuser},");
                                        },
                                        child: Image.asset(
                                            Img.get('whatsapp.png'),
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.fill)),
                                    GestureDetector(
                                        onTap: () {
                                          final url =
                                          Uri.encodeFull('sms:${mobile}?body=Dear ${fromuser},');
                                          UrlLauncher.launch(url);
                                        },
                                        child: Image.asset(Img.get('message.png'),
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.fill)),
                                    GestureDetector(
                                        onTap: () {
                                          final url =
                                          Uri.encodeFull('mailto:${email}?subject=Bug Status&body=Dear ${fromuser},');
                                          UrlLauncher.launch(url);
                                        },
                                        child: Image.asset(Img.get('email.png'),
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.fill)),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Image.asset(Img.get('refresh.png'),
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.fill)),
                                  ],
                                ),
                                Container(height: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey,
                                  child: Text(
                                    "Added Date : "+datetime,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Century Gothic',
                                    ),
                                    textAlign: TextAlign.end, // has impact
                                  ),
                                )
                              ],
                            )))
                        : Center(child: Image.asset("images/no_data.jpg"));
                  })))
    ]);
  }

  callAPI(String searchkey) async {
    var body = {
      "requestfrom": "mobile",
      "my_tickets": "",
      "other_tickets": name,
      "searchkey": searchkey,
    };

    final res = await ApiManager().post("Support/getSupportTickets", body);

    setState(() {
      //    this.ticketData = res;
      if (res["error"] == false) {}
      res["support_tickets"].forEach((data) => {
        this.ticketData.add(SupportTicket.fromJSON(data)),
      });
    });
  }

  checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog();
    } else if (result == ConnectivityResult.mobile) {
      callAPI("");
    } else if (result == ConnectivityResult.wifi) {
      callAPI("");
    }
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 160,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: Colors.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Wrap(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      color: Colors.red[300],
                      child: Column(
                        children: <Widget>[
                          Container(height: 10),
                          Icon(Icons.cloud_off, color: Colors.white, size: 80),
                          Container(height: 10),
                          Text("No internet !",
                              style: MyText.title(context)
                                  .copyWith(color: Colors.white)),
                          Container(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Text("Please Check you are connected to internet",
                              textAlign: TextAlign.center,
                              style: MyText.subhead(context)
                                  .copyWith(color: MyColors.grey_60)),
                          Container(height: 10),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0)),
                            child: Text(
                              "Retry",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red[300],
                            onPressed: () {
                              Navigator.of(context).pop();
                              callAPI("");
                              Toast.show("Retry clicked", context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  onSearchTextChanged(String text) async {
    //  ticketData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    callAPI(text);
  }
}
