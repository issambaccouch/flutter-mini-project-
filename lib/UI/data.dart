import 'dart:convert';

import 'package:flutter_app/NetworkHandler.dart';

// enum Category { CAT, DOG, BUNNY, HAMSTER }
enum Condition { Adoption, Disappear, Mating }

class Pet {
  int pet_id ;
  String pet_name ;
  String pet_picture ;
  String pet_race ;
  String pet_age ;
  String pet_status ;
  String pet_desc ;
  String pet_sex ;
  String createdAt ;
  int owner ;

  Pet(this.pet_id,this.pet_name, this.pet_picture, this.pet_race, this.pet_age,
      this.pet_status, this.pet_desc, this.pet_sex, this.createdAt, this.owner);

  Pet.fromJson(Map<String, dynamic> json)
      : pet_id = json['pet_id'],
        pet_name = json['pet_name'],
        pet_picture = json['pet_picture'],
        pet_race = json['pet_race'],
        pet_status = json['pet_status'],
        pet_desc = json['pet_desc'],
        pet_sex = json['pet_sex'],
        createdAt = json['createdAt'],
        owner = json['owner'],
        pet_age = json['pet_age'];
  Map toJason(){
    return {'pet_id':pet_id,'pet_name':pet_name,
      'pet_picture':pet_picture, 'pet_race':pet_race,
      'pet_status':pet_status, 'pet_desc':pet_desc,
      'pet_sex':pet_sex, 'createdAt':createdAt,
      'owner':owner ,'pet_age':pet_age}  ;
  }


}



