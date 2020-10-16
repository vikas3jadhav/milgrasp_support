import 'package:flutter/material.dart';
import 'package:milgrasp_support/Utils/ApiManager.dart';
import 'package:milgrasp_support/Utils/Constants.dart';
import 'package:milgrasp_support/Utils/SessionManagement.dart';
import 'package:milgrasp_support/data/MyColors.dart';
import 'package:milgrasp_support/data/img.dart';
import 'package:milgrasp_support/model/User.dart';
import 'package:milgrasp_support/widget/MyText.dart';
import 'package:http/http.dart' as http;
import 'package:milgrasp_support/route/dashboard.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget{

  @override
  // TODO: implement createState
    LoginState createState() => new LoginState();
}



class LoginState extends State<Login>{

  User _user;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _formKey = GlobalKey<FormState>();

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: Container(color: Colors.black)),
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Container(color: Colors.black, height: 220),
            Column(
              children: <Widget>[
                Container(height: 40),
                Container(
                  child: Image.asset(
                    Img.get('milgrasp_logo_new.png'),
                    color: Colors.white,
                  ),
                  width: 200, height: 60,
                ),
                Card(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(6)),
                    margin: EdgeInsets.all(25),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child :  Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(height: 25),
                          Text("SIGN IN", style: MyText.title(context).copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Century Gothic'
                          )),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: usernameController,
                            style: TextStyle(color: Colors.black,fontFamily: 'Century Gothic'),
                            validator: (String value){
                              if(value.isEmpty){
                                return "Please enter username";
                              }
                            },
                            decoration: InputDecoration(labelText: "Username",
                              labelStyle: TextStyle(color: Colors.blueGrey[400]),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400], width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400], width: 2),
                              ),
                            ),
                          ),
                          Container(height: 25),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            style: TextStyle(color: Colors.black,fontFamily: 'Century Gothic'),
                            validator: (String value){
                              if(value.isEmpty){
                                return "Please enter password";
                              }
                            },
                            decoration: InputDecoration(labelText: "Password",
                              labelStyle: TextStyle(color: Colors.blueGrey[400]),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400], width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey[400], width: 2),
                              ),
                            ),
                          ),
                          Container(height: 25),
                          Container(
                            width: double.infinity,
                            height: 40,
                            child: FlatButton(
                              child: Text("SUBMIT",
                                style: TextStyle(color: Colors.white,fontFamily: 'Century Gothic'),),
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20)
                              ),
                              onPressed:  () {
                                if (_formKey.currentState.validate()) {
                                 callLoginAPI();
                                }else{

                                }
                              },
                            ),
                          ),
//                        Container(
//                          width: double.infinity,
//                          child: FlatButton(
//                            child: Text("New user? Sign Up",
//                              style: TextStyle(color: MyColors.primaryLight),),
//                            color: Colors.transparent,
//                            onPressed: () {},
//                          ),
//                        ),
                        ],
                      ),
                    )
                )
              ],
            )
          ],
        ),
      )
    );
  }

  void callLoginAPI() async {
    //this.changeLoadingStatus(true); 1ujk19 - demo,  242854-billi

    var body = {
      'requestfrom': "mobile",
      'username': this.usernameController.text,
      'loginfrom': "Android",
      'mobileos': "Android",
      'password': this.passwordController.text,
    };

    final res = await ApiManager().post("Login/checkusernamepassword/", body);

    if (res["error"] == false) {
      this.saveDetails(res["user"][0]["name"],
          res["user"][0]["username"],
          res["user"][0]["usertype"],
          res["user"][0]["department"],
          res["user"][0]["email"],
          res["user"][0]["mobile"],
          res["user"][0]["dob"],
          res["user"][0]["gender"],
          res["user"][0]["branch"],
          res["user"][0]["pic"]);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      Toast.show("Wrong Username or password", context);

    }
  }

  saveDetails(String name, String username, String usertype, String department, 
      String email, String mobile, String dob, String gender, String branch, String pic) {
    
    Constants.name = name;
    Constants.username = username;
    Constants.usertype = usertype;
    Constants.department = department;
    Constants.email = email;
    Constants.mobile = mobile;
    Constants.dob = dob;
    Constants.gender = gender;
    Constants.branch = branch;
    Constants.pic = pic;
    

    SessionManagement.saveUserLoggedInSharedPreference(true);
    SessionManagement.saveNameSharedPreference(name);
    SessionManagement.saveUserNameSharedPreference(username);
    SessionManagement.saveUsertypeSharedPreference(usertype);
    SessionManagement.saveDepartmentSharedPreference(department);
    SessionManagement.saveEmailSharedPreference(email);
    SessionManagement.saveDobSharedPreference(dob);
    SessionManagement.saveGenderSharedPreference(gender);
    SessionManagement.saveBranchSharedPreference(branch);
    SessionManagement.savePicSharedPreference(pic);
    
    
    
  }

}
