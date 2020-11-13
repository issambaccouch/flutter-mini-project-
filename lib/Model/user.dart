class User {
  int user_id ;
  String user_username;
  String user_email;
  String user_firstname;
  String user_lastname;
  String user_picture ;
  String user_address ;
  String createdAt ;
  User(this.user_id,this.user_username, this.user_email, this.user_firstname,
      this.user_lastname, this.user_picture, this.user_address,this.createdAt);

  User.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        user_username = json['user_username'],
        user_email = json['user_email'],
        user_firstname = json['user_firstname'],
        user_lastname = json['user_lastname'],
        user_picture = json['user_picture'],
        createdAt = json['createdAt'];
  Map toJason(){
  return {'user_id':user_id,'user_username':user_username,
  'user_email':user_email, 'user_firstname':user_firstname,
  'user_lastname':user_lastname, 'user_picture':user_picture,
  'user_address':user_address, 'createdAt':createdAt };
  }


}