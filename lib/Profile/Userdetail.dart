
import 'dart:async';

import 'package:flutter_app/Model/user.dart';
import 'package:flutter_app/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class UserDetail extends StatefulWidget {
  final User petowner;
  UserDetail({Key key , this.petowner}) : super(key: key);
  @override
  _UserDetailState createState() => _UserDetailState(petowner);
}

class _UserDetailState extends State<UserDetail> {
  var imageUrl = "http://10.0.2.2:3000/petrescue/public/img/";

  final User petowner;
  _UserDetailState(this.petowner);
  bool circular = false;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: <Widget>[
          head(),
          Divider(
            thickness: 0.8,
          ),
          otherDetails("username", petowner.user_username),
          sendemail("email", petowner.user_email),
          otherDetails("Adress", petowner.user_address),
          phone("Phone", petowner.user_phonenumber),
          Divider(
            thickness: 0.8,
          ),
        ],
      ),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl+petowner.user_picture),
            ),

          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
  Widget sendemail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row (
              children: <Widget>[
                Text(
                  value + "  ",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "Send Email: " ,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox.fromSize(
                  size: Size(40, 40), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.yellowAccent, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () {
                          UrlLauncher.launch('mailto:${value.toString()}') ;
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.email), // icon
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          )
        ],
      ),
    );
  }
  Widget phone(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row (
              children: <Widget>[
                Text(
                  value + "  ",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "     Call Owner : " ,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox.fromSize(
                  size: Size(40, 40), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.red, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () {
                          UrlLauncher.launch('tel:${value.toString()}') ;
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.call), // icon
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "  "+"SMS: ",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                SizedBox.fromSize(
                  size: Size(40, 40), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.greenAccent, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () {
                          UrlLauncher.launch('sms:${value.toString()}') ;
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.sms), // icon
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
          )
        ],
      ),
    );
  }


}
