import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/sharedPref.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkHandler {
  String baseurl = "http://10.0.2.2:3000/petrescue";
  var log = Logger();

  Future get(String url) async {
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }

  }
  Future <http.Response>login(email , password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;

    final response = await http.get("$baseurl/user/$email/$password");
    if(response.statusCode == 200 || response.statusCode == 201 ){
      var jsonData =  json.decode(response.body);
      sharedPreferences.setString('user_email', jsonData[0]["user_email"]);
      sharedPreferences.setString('user_username', jsonData[0]["user_username"]);
      var test = sharedPreferences.getString("user_email");
   log.i(test);
    }
    return response ;
    }
  Future <http.Response> register(username ,email ,password) async {
   var url = "$baseurl/signup" ;
   log.i(url) ;
    var response = await http.post(
     url,
      headers: <String, String>{
        "Content-type": "application/json;charset=UTF-8",
      },
      body: json.encode(<String , String>{
          'user_username':username,
          'user_email':email,
          'password':password

      }


      ),
    );
    return response;
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String username) {
    String url = formater("/uploads//$username.jpg");
    return NetworkImage(url);
  }
}
