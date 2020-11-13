import 'package:flutter/material.dart';
import 'package:flutter_app/UI/data.dart';
import 'package:flutter_app/UI/pet_detail.dart';

class PetWidget extends StatelessWidget {
  var imageUrl = "http://10.0.2.2:3000/petrescue/public/img/";

  final Pet pet;
  final int index;

  PetWidget({@required this.pet, @required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetDetail(pet: pet)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.grey[200],
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(right: index != null ? 16 : 0, left: index == 0 ? 16 : 0, bottom: 16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              child: Stack(
                children: [

                  Hero(
                    tag: pet.pet_picture,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl+pet.pet_picture),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:  Colors.red[400] ,
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 16,
                          color: Colors.white ,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    decoration: BoxDecoration(
                      color: pet.pet_status == "Adoption" ? Colors.orange[100] : pet.pet_status == "Lost" ? Colors.red[100] : Colors.blue[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      pet.pet_status,
                      style: TextStyle(
                        color: pet.pet_status == "Adoption" ? Colors.orange : pet.pet_status == "Lost" ? Colors.red : Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    pet.pet_name,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
                        size: 18,
                      ),

                      SizedBox(
                        width: 4,
                      ),

                      Text(
                        pet.createdAt.substring(0,10),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),

                      SizedBox(
                        width: 4,
                      ),

                      Text(
                        "(" + pet.pet_race + ")",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}