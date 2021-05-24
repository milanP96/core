import 'package:rd_health/config/httpClient.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User(
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.avatar,);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        email = json['email'],
        lastName = json['last_name'],
        avatar = json['avatar'] != null ?json['avatar']['image'] : null;
}
