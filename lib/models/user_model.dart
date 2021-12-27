class UserModel
{
  late String uId;
  late String name;
  late String email;
  late String phone;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}