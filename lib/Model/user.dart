class User {
  String user_username;
  String user_email;
  String user_firstname;
  String user_lastname;
  String user_picture ;
  String user_address ;
  String user_phonenumber ;
  String createdAt ;

  User({this.user_username, this.user_email, this.user_firstname,
      this.user_lastname, this.user_picture, this.user_address,this.user_phonenumber,this.createdAt});
  User.fromJson(Map<String, dynamic> json)
      : user_username = json['user_username'],
        user_email = json['user_email'],
        user_firstname = json['user_firstname'],
        user_lastname = json['user_lastname'],
        user_picture = json['user_picture'],
        user_address=json['user_address'],
        user_phonenumber = json['user_phonenumber'],
        createdAt = json['createdAt'];
  Map toJason(){
  return {'user_username':user_username,
  'user_email':user_email, 'user_firstname':user_firstname,
  'user_lastname':user_lastname, 'user_picture':user_picture,
  'user_address':user_address,'user_phonenumber':user_phonenumber,'createdAt':createdAt };
  }


}