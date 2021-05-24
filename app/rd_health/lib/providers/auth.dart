import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rd_health/config/httpClient.dart';

import 'package:rd_health/models/http_exception.dart';
import 'package:rd_health/models/user.dart';

class Auth with ChangeNotifier {
  String _token;
  String firebaseToken;
  User _user;

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  User get user {
    return _user;
  }

  void setFirebaseToken(String token) {
    firebaseToken = token;
    notifyListeners();
  }

  Future<void> _authenticate(String email, String password,
      {String token = ''}) async {
    // final url = 'http://192.168.0.18:8000/api/user/token/';
    try {
      if (token.isEmpty) {
        final response =
            await httpClient('user/token/', null).post(json.encode(
          {
            'email': email,
            'password': password,
          },
        ));

        if(response.statusCode != 200) {
          throw("error");
        }

        final responseData = json.decode(utf8.decode(response.bodyBytes));

        _token = responseData['token'];
        notifyListeners();
      } else {
        _token = token;
        notifyListeners();
      }

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
        },
      );
      prefs.setString('userData', userData);
      fetchMe();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<void> login(String email, String password,
      {String token = '', String authProvider = 'email'}) async {

    if (authProvider != 'email') {
      final response =
          await httpClient('user/$authProvider/', null).post(json.encode(
        {'auth_token': token},
      ));
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      return _authenticate(email, password, token: responseData['token']);
    }
    return _authenticate(email, password);
  }

  Future<bool> tryAutoLogin({String firebaseToken}) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    print(_token);
    notifyListeners();
    if(firebaseToken != null) {
      fetchMe(fToken: firebaseToken);
    } else {
      fetchMe();
    }

    return true;
  }

  Future<void> logout() async {
    print("Usao je u logout");
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
    notifyListeners();
    print(prefs.getString('userData'));
    print("IZNAD A ISPOD JE TOKEN");
    print(token);
  }

  Future<void> fetchMe({String fToken}) async {
    print("Fetch me");
    final response = await httpClient('user/me/', _token).get();

    final responseData = json.decode(utf8.decode(response.bodyBytes));
    print(responseData);
    print("Fetch me" + responseData.toString());
    _user = User.fromJson(responseData);
    notifyListeners();

    if(firebaseToken != null) {
      Map<String, String> body = new Map();
      body["firebase_token"] = firebaseToken;
      httpClient('tours/guides/${_user.id.toString()}/', _token).patch(json.encode(body));
    }

    if(fToken != null) {
      Map<String, String> body = new Map();
      body["firebase_token"] = fToken;
      httpClient('tours/guides/${_user.id.toString()}/', _token).patch(json.encode(body));
    }
  }

  Future<bool> register(Map<String, dynamic> body) async {
    try {
      final res = await httpClient('user/register/', _token).post(json.encode(
        body,
      ));
      print("Ispodddd  jee jd");
      print(res.statusCode);
      if(res.statusCode == 417) {
        throw("email");
      }
      return true;
    } catch(e) {
      throw(e);
    }
  }

  Future editProfile(Map<String, dynamic> body) async {
    final res = await httpClient('user/edit/', _token).patch(json.encode(
      body,
    ));

    fetchMe();
    // print(json.decode(res.body));
  }

  Future forgotPassword(Map<String, dynamic> body) async {
    final res = await httpClient('user/forgot_password/', null).post(json.encode(
      body,
    ));
    // print(json.decode(res.body));
  }

  Future<bool> resetPassword(Map<String, dynamic> body) async {

    try {
      final resp = await httpClient('user/reset_password/', null).post(json.encode(
        body,
      ));
      await login(body["email"], body["new_password"]);
      return true;
    } catch(e) {
      print(e);
      return false;
    }
    // print(json.decode(res.body));
  }
}
