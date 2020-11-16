import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Model/user.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:flutter_app/Profile/Userdetail.dart';
import 'package:flutter_app/UI/data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NetworkHandler.dart';

class PetDetail extends StatefulWidget {

  final Pet pet;
  PetDetail({@required this.pet});
  @override
  _PetDetailState createState() => _PetDetailState(pet);

}
class _PetDetailState extends State<PetDetail> {
  var log = Logger();

  final Pet pet;
  _PetDetailState(this.pet);
  int currentuserid ;
  NetworkHandler networkHandler = NetworkHandler();
   var imageUrl = "http://10.0.2.2:3000/petrescue/public/img/";
      User  user = new User(user_phonenumber: "0",user_address: "0",user_picture: "don.jpg",user_email: "email",user_username: "fefef") ;
    _getSharedper()async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      currentuserid =  sharedPreferences.getInt("user_id");
    }
  _getUser() {
    networkHandler.getUser(pet.owner).then((response) {
      if(response.statusCode == 200 || response.statusCode == 201 ){
        var   res =  jsonDecode(response.body);
        var userone =  res.map((model) => User.fromJson(model)).toList();
        user = userone[0];
      }
    });
  }
  initState() {
    super.initState();
    _getUser();
    _getSharedper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: pet.pet_picture,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("$imageUrl/"+pet.pet_picture),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            pet.pet_name,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Row(
                            children: [

                              Icon(
                                Icons.location_on,
                                color: Colors.grey[600],
                                size: 20,
                              ),

                              SizedBox(
                                width: 4,
                              ),

                              Text(
                                pet.createdAt.substring(0,10),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),

                              SizedBox(
                                width: 4,
                              ),

                              Text(
                                "(" + pet.pet_status + ")",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),

                     InkWell(
                       child:Container(
                         height: 50,
                         width: 50,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: Colors.red[400],
                           // color: pet.favorite ? Colors.red[400] : Colors.white,
                         ),
                         child: pet.owner == currentuserid? Icon(
                           Icons.delete_forever,
                           size: 36,
                           color: Colors.white,
                           // color: pet.favorite ? Colors.white : Colors.grey[300],
                         ):Icon(
                           Icons.favorite,
                           size: 24,
                           color: Colors.white,
                           // color: pet.favorite ? Colors.white : Colors.grey[300],
                         ),
                       ) ,
                       onTap: () {
                         print("pressed");
                         showDialog<void>(
                           context: context,
                           barrierDismissible: false, // user must tap button!
                           builder: (BuildContext context) {
                             return AlertDialog(
                               title: Text('Delete this Pet'),
                               content: SingleChildScrollView(
                                 child: ListBody(
                                   children: <Widget>[
                                     Text('you are going to delete this pet '),
                                     Text('Are you sure?'),
                                   ],
                                 ),
                               ),
                               actions: <Widget>[
                                 TextButton(
                                   child: Text('Approve'),
                                   onPressed: () {
                                     print("deleted") ;
                                     deletePet(pet.pet_id);
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => HomePage()),
                                     );
                                   },
                                 ),
                                 TextButton(
                                   child: Text('Cancel'),
                                   onPressed: () {
                                     Navigator.of(context).pop();
                                   },
                                 ),
                               ],
                             );
                           },
                         );
                       }
                     ) ,

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [

                      buildPetFeature(pet.pet_age, "Age"),
                      buildPetFeature(pet.pet_sex, "Gender"),
                      buildPetFeature(pet.pet_race, "Race"),

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Pet Story",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    pet.pet_desc,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [

                          UserAvatar(),

                          SizedBox(
                            width: 12,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                "Posted by",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                height: 4,
                              ),

                              Text(
                               user?.user_username,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                            InkWell(
                               child:Container(
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue[300].withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: Colors.blue[300],
                                  ),
                                  child: Text(
                                    "Contact Me",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UserDetail(petowner: user)),
                                );
                              },
                            ),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  buildPetFeature(String value, String feature){
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [

            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 3,
            ),

            Text(
              feature,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),

          ],
        ),
      ),
    );
  }
 deletePet(pet_id){
    print(pet_id);
   networkHandler.deletePet(pet_id).then((response) {
     if(response.statusCode == 200 || response.statusCode == 201 ){
       Fluttertoast.showToast(
           msg: "Pet Deleted 😭",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
   });
 }
   UserAvatar() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl+user.user_picture),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }

}