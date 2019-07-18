import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  static const String _apiKey = 'AIzaSyDnJVWS59nBVsa4AOjkXUftFkhSej6ALko';
  static const String apiBase =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/';
  static const String registerEndPoint = 'signupNewUser?key=$_apiKey';
  static const String loginEndPoint = 'verifyPassword?key=$_apiKey';

  Future<void> registerWithEmailAndPass(
    String email,
    String pass,
  ) async {
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
      return;
    } else {
      print(response.body);
      throw response.statusCode;
    }
  }

  Future<void> loginWithEmailAndPass(
    String email,
    String pass,
  ) async {
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
