import 'dart:convert';
import 'package:milgrasp_support/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

final hostName = "https://final.milgrasp.com/";

class ApiManager {
  ApiManager() {}

  Future<dynamic> get(String url) async {
    url = hostName + url;
    print(url);

    http.Response response = await http.get(url);

    print("URL: $url");
    debugPrint("API Response: ${response.body}");
    return jsonDecode(response.body);
  }

  Future<dynamic> post(String url, dynamic param) async {
    url = hostName + url;


    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(param));

    print("URL: $url");
    print("Body: $param");
    log("API Response: ${response.body}");

    return json.decode(response.body);
  }
}
