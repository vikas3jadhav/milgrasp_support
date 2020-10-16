import 'package:flutter/material.dart';
import 'package:milgrasp_support/route/my_tickets.dart';
import 'package:milgrasp_support/route/statistics_assign_to.dart';
import 'package:milgrasp_support/route/statistics_domain.dart';
import 'package:milgrasp_support/route/statistics_platform.dart';
import 'package:milgrasp_support/route/statistics_priority.dart';
import 'package:milgrasp_support/route/statistics_status.dart';
import 'package:milgrasp_support/route/statistics_todays_count.dart';
import 'package:milgrasp_support/route/statistics_total_count.dart';
import 'package:milgrasp_support/widget/MyText.dart';

class Statistics extends StatefulWidget {
  @override
  StatisticsState createState() => new StatisticsState();
}

class StatisticsState extends State<Statistics>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

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
              "Statistics",
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
            bottom: TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              isScrollable: true,
              labelStyle: MyText.subhead(context)
                  .copyWith(fontWeight: FontWeight.w500,fontFamily: 'Century Gothic', color: Colors.white),
              unselectedLabelColor: Colors.grey[400],
              tabs: [
                Tab(text: "Todays"),
                Tab(text: "Total"),
                Tab(text: "Assign To"),
                Tab(text: "Priority"),
                Tab(text: "Status"),
                Tab(text: "Domain"),
                Tab(text: "Platform"),
              ],
              controller: _tabController,
            ),
          ),
          body: TabBarView(
            children: [
              StatisticsTodaysCount(),
              StatisticsTotalCount(),
              StatisticsAssignToCount(),
              StatisticsPriorityCount(),
              StatisticsStatusCount(),
              StatisticsDomainCount(),
              StatisticsPlatformCount(),
            ],
            controller: _tabController,
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
