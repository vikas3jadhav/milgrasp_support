import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement {
  static String sharedPreferenceLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceNameKey = "NAME";
  static String sharedPreferenceUserNameKey = "USERNAME";
  static String sharedPreferenceDepartmentKey = "DEPARTMENT";
  static String sharedPreferenceUsertypeKey = "USERTYPE";
  static String sharedPreferenceEmailKey = "EMAIL";
  static String sharedPreferenceMobileKey = "MOBILE";
  static String sharedPreferenceDobKey = "DOB";
  static String sharedPreferenceGenderKey = "GENDER";
  static String sharedPreferenceBranchKey = "BRANCH";
  static String sharedPreferencePicKey = "PIC";

  /// saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveNameSharedPreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceNameKey, name);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveDepartmentSharedPreference(String department) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceDepartmentKey, department);
  }


  static Future<bool> saveUsertypeSharedPreference(String usertype) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUsertypeKey, usertype);
  }

  static Future<bool> saveEmailSharedPreference(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceEmailKey, email);
  }

  static Future<bool> saveMobileSharedPreference(String mobile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceMobileKey, mobile);
  }

  static Future<bool> saveDobSharedPreference(String dob) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceDobKey, dob);
  }

  static Future<bool> saveGenderSharedPreference(String gender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceGenderKey, gender);
  }

  static Future<bool> saveBranchSharedPreference(String branch) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceBranchKey, branch);
  }

  static Future<bool> savePicSharedPreference(String pic) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencePicKey, pic);
  }

  /// fetching data from sharedpreference

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceLoggedInKey);
  }

  static Future<String> getNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceNameKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getDepartmentSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceDepartmentKey);
  }

  static Future<String> getUsertypeSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUsertypeKey);
  }

  static Future<String> getEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceEmailKey);
  }

  static Future<String> getMobileSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceMobileKey);
  }

  static Future<String> getDobSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceDobKey);
  }

  static Future<String> getGenderSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceGenderKey);
  }

  static Future<String> getBranchSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceBranchKey);
  }

  static Future<String> getPicSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferencePicKey);
  }

}
