
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/user.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MainProfile extends StatefulWidget {
   final User user ;
  MainProfile({Key key,@required this.user}) : super(key: key);

  @override
  _MainProfileState createState() => _MainProfileState(user);
}

class _MainProfileState extends State<MainProfile> {
  final User user ;
  _MainProfileState(this.user);
  bool circular = false;
  var imageUrl = "http://10.0.2.2:3000/petrescue/public/img/";
  String email = "";
  String username = "";
  String userpicture  = "";
  String useradress = "";
  String  userphonenumber = "";
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          color: Colors.black,
        ),
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                head(),
                SizedBox(
                  height: 100,
                ),
                Divider(
                  thickness: 0.8,
                ),
                otherDetails("@username", user.user_username),
                otherDetails("email", user.user_email),
                otherDetails("Address", user.user_address),
                otherDetails("Phone", user.user_phonenumber),
                Divider(
                  thickness: 0.8,
                ),
              ],
            ),
    );
  }


  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Image(
              height: MediaQuery.of(context).size.height/4,
              fit: BoxFit.cover,
              image :AssetImage('assets/cover2.jpg')),
          Positioned(
            top: 130,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(blurRadius: 10, color: Colors.black, spreadRadius: 5)
                  ],
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(imageUrl+user.user_picture),
                )),

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

}
