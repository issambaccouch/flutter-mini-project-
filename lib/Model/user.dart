class User {
  String user_username;
  String user_email;
  String user_firstname;
  String user_lastname;
  String user_picture ;
  String user_address ;
  User();

  User.fromJson(Map<String, dynamic> json)
      : user_username = json['user_username'],
        user_email = json['user_email']
      ;

  Map<String, dynamic> toJson() => {
    'user_username': user_username,
    'user_email': user_email

  };
}