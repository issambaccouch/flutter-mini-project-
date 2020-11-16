import 'package:flutter_app/Model/user.dart';
import 'package:flutter_app/NetworkHandler.dart';
import 'package:flutter_app/Profile/CreatProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MainProfile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
    var username = sharedPreferences.getString("user_username");
     var  email = sharedPreferences.getString("user_email");
      var userpicture  = sharedPreferences.getString('user_picture');
     var  useradress = sharedPreferences.getString('user_address');
      var userphonenumber = sharedPreferences.getString('user_phonenumber');
       User user = new User(user_username: username, user_email: email,user_picture: userpicture,user_address: useradress,user_phonenumber: userphonenumber);
    if (username != null) {
      setState(() {
        page = MainProfile(user : user);
      });
    } else {
      setState(() {
        page = button();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
    );
  }

  Widget showProfile() {
    return Center(child: Text("Profile Data is Avalable"));
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Tap to button to add profile data",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatProfile()))
            },
            child: Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Add Proile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
