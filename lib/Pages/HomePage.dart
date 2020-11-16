import 'dart:convert';

import 'package:flutter_app/Blog/addPet.dart';
import 'package:flutter_app/Pages/WelcomePage.dart';
import 'package:flutter_app/Screen/HomeScreen.dart';
import 'package:flutter_app/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/data.dart';
import 'package:flutter_app/UI/mypet_list.dart';
import 'package:flutter_app/UI/principal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_app/NetworkHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imageUrl = "http://10.0.2.2:3000/petrescue/public/img/";
  var pets = new List<Pet>();
  _getPets() {
    networkHandler.getPets().then((response) {
      setState(() {
        Iterable res =  json.decode(response.body);
        pets = res.map((model) => Pet.fromJson(model)).toList();
      });
    });
  }
  var log = Logger();
  int currentState = 0;
  List<Widget> widgets = [Principal(), ProfileScreen()];
  List<String> titleString = ["Home Page", "Profile Page"];
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  String userpicture = "" ;
  int currentuserid ;

  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
    _getPets();

  }

  void checkProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
     username = sharedPreferences.getString("user_username");
     userpicture = sharedPreferences.getString("user_picture");
      currentuserid = sharedPreferences.getInt("user_id");
     log.i(username);
    setState(() {
      username = username;
    });
    if (username != null ) {
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(imageUrl+userpicture) ,
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  profilePhoto,
                  SizedBox(
                    height: 10,
                  ),
                  Text("@$username"),
                ],
              ),
            ),
            ListTile(
              title: Text("Home" ,style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.home),
              onTap: () {
               Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: Text("Add new Pet ",style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.add),
              onTap: () {
                Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddPet()));},
            ),
            ListTile(
              title: Text("My Pets", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.pets),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MypetList(currentuser: currentuserid, pets: pets)));
              },
            ),
            ListTile(
              title: Text("View Profile" ,style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.person),
              onTap: () {
                 Navigator.of(context)
                   .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),

            ListTile(
              title: Text("Logout" , style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.power_settings_new),
              onTap: logout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(titleString[currentState]),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPet()));
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 40,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: currentState == 1 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 40,
                )
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }

  void logout()  {
    // await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
