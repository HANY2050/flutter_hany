import 'package:generalshops/exceptions/exceptions.dart';

class User {
  int user_id;
  String first_name;
  String last_name;
  String city;
  String address;
  String email;
  String mobile;
  String api_token;
  User(this.first_name, this.mobile, this.last_name, this.email,
      [this.user_id, this.api_token]);

  User.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['user_id'] != null, 'User ID is null');
    assert(jsonObject['first_name'] != null, 'User First Name is null');
    assert(jsonObject['last_name'] != null, 'User Last Name is null');
    assert(jsonObject['city'] != null, 'User city is null');
    assert(jsonObject['address'] != null, 'User address is null');
    assert(jsonObject['email'] != null, 'User Email is null');
    assert(jsonObject['mobile'] != null, 'User mobile is null');
    assert(jsonObject['api_token'] != null, 'User Api Token is null');

    if (jsonObject['user_id'] == null) {
      throw PropertyIsRequired('User ID');
    }
    if (jsonObject['first_name'] == null) {
      throw PropertyIsRequired('User First Name');
    }
    if (jsonObject['last_name'] == null) {
      throw PropertyIsRequired('User Last Name');
    }

    if (jsonObject['city'] == null) {
      throw PropertyIsRequired('User city');
    }
    if (jsonObject['address'] == null) {
      throw PropertyIsRequired('User address');
    }
    if (jsonObject['email'] == null) {
      throw PropertyIsRequired('User Email');
    }
    if (jsonObject['mobile'] == null) {
      throw PropertyIsRequired('User Mobile');
    }
    if (jsonObject['api_token'] == null) {
      throw PropertyIsRequired('User  Api Token');
    }

    this.user_id = jsonObject['user_id'];
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.city = jsonObject['city'];
    this.address = jsonObject['address'];
    this.email = jsonObject['email'];
    this.mobile = jsonObject['mobile'];
    this.api_token = jsonObject['api_token'];
  }
}
