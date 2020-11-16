import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/sharedPref.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkHandler {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final String serverToken = 'AAAAnrQOMvA:APA91bE2w6DuPHS2Dm-jRPnWUFP66SqA5UJUqHgyDgAv1k2hI13IaiLz4kn9QWf2XnrTS_uGi2gIx2Kh1ZygqD-ifH3YaRyaCew0zp0IdKiw2-gXbvmT_-ce0FHygwNuSSEcULJPQbZ6';
  String baseurl = "http://10.0.2.2:3000/petrescue";
  var log = Logger();
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
   print(await firebaseMessaging.getToken()) ;
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'a new Pet need your help heros',
            'title': 'Pet Added',
            'image': 'https://www.pawsforthesoul.com/wp-content/uploads/2019/03/Pet-Rescue.jpg'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': "fJ-KZ2opRn6T_8NBIGOLwJ:APA91bFpNGTyAXFXon_t_9YsRiUPBGJiIevJo23cwnFnQpUEbT5OXK79RzvxHTOrzTXpvFddEp-EgpFuZO1DwQMrRGFMLCowKUuPhPKb1HpuO6eXZrh1nWyrXvnSYbZP32K3yabyY8Y6",
        },
      ),
    );
    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
  Future get(String url) async {
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }

  }

  Future getUser(user_id)   {
   var url  = "http://10.0.2.2:3000/petrescue/user/$user_id";
    return http.get(url) ;
    }

  Future deletePet(pet_id) {
    var url = "http://10.0.2.2:3000/petrescue/mypets/$pet_id";
    return http.delete(url);
  }

   Future getPets() {
    var url = "http://10.0.2.2:3000/petrescue/pets";
    return http.get(url);
  }

  Future <http.Response>login(email , password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
    final response = await http.get("$baseurl/user/$email/$password");
    if(response.statusCode == 200 || response.statusCode == 201 ){
      var jsonData =  json.decode(response.body);
      sharedPreferences.setString('user_email', jsonData[0]["user_email"]);
      sharedPreferences.setString('user_username', jsonData[0]["user_username"]);
      sharedPreferences.setInt('user_id', jsonData[0]["user_id"]);
      sharedPreferences.setString('user_picture', jsonData[0]["user_picture"]);
      sharedPreferences.setString('user_address', jsonData[0]["user_address"]);
      sharedPreferences.setString('user_phonenumber', jsonData[0]["user_phonenumber"]);
    }
    return response ;
    }
  Future <http.Response> register(username ,email ,password,phone,adress,picture) async {
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
          'password':password,
          'user_picture':picture ,
          'user_address':adress ,
          'user_phonenumber':phone ,
      }


      ),
    );
    return response;
  }

  Future <http.Response> addpet(pet_name ,pet_race ,pet_age,pet_status,pet_desc,pet_sex,pet_picture) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
    var owner = sharedPreferences.getInt("user_id");

    var url = "$baseurl/mypets" ;
    log.i(url) ;
    var response = await http.post(
      url,
      headers: <String, String>{
        "Content-type": "application/json;charset=UTF-8",
      },
      body: json.encode(<String , dynamic>{
        'pet_name':pet_name,
        'pet_race':pet_race,
        'pet_age':pet_age,
        'pet_status':pet_status,
        'pet_desc':pet_desc,
        'pet_sex':pet_sex,
        "pet_picture":pet_picture,
        'owner':owner
      }
      ),
    );

    return response;
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = (url);
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

  Future<http.StreamedResponse> addImage(String url, String filepath) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("avatar", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = request.send();
    return response;
  }

}
