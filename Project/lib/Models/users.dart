class Users {
  final int? userId;
  final String userName;
  final String password;
  String? email;
  String? hint;

  Users({
    this.userId,
    required this.userName,
    required this.password,
    this.email,
    this.hint,
  });


  factory Users.fromMap(Map<String, dynamic> json) => Users(
    userId: json["user_id"],
    userName: json["user_name"],
    password: json["password"],
    email: json["email"],
    hint: json["hint"],
  );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "user_name": userName,
    "password": password,
    "email": email,
    "hint": hint,
  };
}
