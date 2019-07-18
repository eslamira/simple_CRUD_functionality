import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  /// the WebAPI key for the firebase project
  static const String _apiKey = 'AIzaSyDnJVWS59nBVsa4AOjkXUftFkhSej6ALko';

  /// the main url of the api
  static const String apiBase =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/';
  static const String registerEndPoint = 'signupNewUser?key=$_apiKey';
  static const String loginEndPoint = 'verifyPassword?key=$_apiKey';

  /// Register method to register using e-mail and pass
  /// returns a UserModel if successful
  Future<void> registerWithEmailAndPass(String email, String pass) async {
    var data = json.encode({
      "email": "$email",
      "password": "$pass",
      "returnSecureToken": true,
    });
    http.Response response = await http.post(
      "$apiBase$registerEndPoint",
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      print(response.body);
      throw response.statusCode;
    }
  }

  /// Login method to login using e-mail and pass
  /// returns a UserModel if successful
  Future<void> loginWithEmailAndPass(String email, String pass) async {
    var data = json.encode({
      "email": "$email",
      "password": "$pass",
      "returnSecureToken": true,
    });
    http.Response response = await http.post(
      "$apiBase$loginEndPoint",
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      print(response.body);
      throw response.statusCode;
    }
  }
}
