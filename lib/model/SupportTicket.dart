// To parse this JSON data, do
//
//     final supportTicket = supportTicketFromJson(jsonString);

import 'dart:convert';

class SupportTicket {
  String fromuser;
  String fromuserdesignation;
  String fromuserpic;
  String assignedusername;
  String milearth_employee_pic;
  String milearth_employee_designation;
  String title;
  String description;
  String subdomain;
  String feature;
  String usertype;
  String section;
  String appversion;
  String mobile;
  String platform;
  String status;
  String datetime;
  String androidmodel;
  String androiddevice;
  String androidversion;
  String priority;
  String fromuseremail;


  SupportTicket({
    this.fromuser,
    this.fromuserdesignation,
    this.fromuserpic,
    this.assignedusername,
    this.milearth_employee_pic,
    this.milearth_employee_designation,
    this.description,
    this.subdomain,
    this.feature,
    this.usertype,
    this.section,
    this.appversion,
    this.mobile,
    this.title,
    this.platform,
    this.status,
    this.datetime,
    this.androidmodel,
    this.androiddevice,
    this.androidversion,
    this.priority,
    this.fromuseremail
  });

  SupportTicket.fromJSON(Map<String, dynamic> json) {
    fromuser = json["fromuser"];
    fromuserdesignation = json["fromuserdesignation"];
    fromuserpic = json["fromuserpic"];
    assignedusername = json["assignedusername"];
    milearth_employee_pic = json["milearth_employee_pic"];
    milearth_employee_designation = json["milearth_employee_designation"];
    title = json["title"];
    description = json["description"];
    subdomain = json["subdomain"];
    feature = json["feature"];
    usertype = json["usertype"];
    section = json["section"];
    appversion = json["appversion"];
    mobile = json["mobile"];
    platform = json["platform"];
    datetime = json["datetime"];
    status = json["status"];
    androidmodel = json["androidmodel"];
    androiddevice = json["androiddevice"];
    androidversion = json["androidversion"];
    priority = json["priority"];
    fromuseremail = json["fromuseremail"];
  }
}
