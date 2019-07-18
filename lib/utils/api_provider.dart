import 'dart:convert';

import 'package:elrizk_task/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  /// making singleton
  static ApiProvider _instance = ApiProvider.internal();
  ApiProvider.internal();
  factory ApiProvider() => _instance;

  /// Firebase Project ID
  static const String projectId = 'elrizk-task';

  /// the WebAPI key for the firebase project
  static const String _apiKey = 'AIzaSyDnJVWS59nBVsa4AOjkXUftFkhSej6ALko';

  /// the main url of the api
  static const String authApiBase =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/';

  /// Register EndPoint
  static const String registerEndPoint = 'signupNewUser?key=$_apiKey';

  /// Login EndPoint
  static const String loginEndPoint = 'verifyPassword?key=$_apiKey';

  /// DeleteAccount EndPoint
  static const String deleteAccountEndPoint = 'deleteAccount?key=$_apiKey';

  /// Register method to register using e-mail and pass
  /// returns a [FirebaseUser] if successful
  Future<FirebaseUser> registerWithEmailAndPass(
      String email, String pass) async {
    var data = json.encode({
      "email": "$email",
      "password": "$pass",
      "returnSecureToken": true,
    });
    http.Response response = await http.post(
      "$authApiBase$registerEndPoint",
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return FirebaseUser.parser(json.decode(response.body));
    } else {
      throw response.statusCode;
    }
  }

  /// Login method to login using e-mail and pass
  /// returns a [FirebaseUser] if successful
  Future<FirebaseUser> loginWithEmailAndPass(String email, String pass) async {
    var data = json.encode({
      "email": "$email",
      "password": "$pass",
      "returnSecureToken": true,
    });
    http.Response response = await http.post(
      "$authApiBase$loginEndPoint",
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return FirebaseUser.parser(json.decode(response.body));
    } else {
      throw response.statusCode;
    }
  }

  /// method to delete the user
  Future<void> deleteUser(String token) async {
    var data = json.encode({
      "idToken": "$token",
    });
    http.Response response = await http.post(
      "$authApiBase$registerEndPoint",
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.statusCode;
    }
  }

  /// Writing User's data in the RealTime DB
  Future<void> putUserData(String uid, data) async {
    http.Response response = await http
        .put('https://$projectId.firebaseio.com/users/$uid.json', body: data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // success
    } else {
      throw response.statusCode;
    }
  }

  /// getting User's data from the RealTime DB
  /// returns a [UserModel] if successful
  Future<UserModel> getUserData(FirebaseUser user) async {
    http.Response response = await http
        .get('https://$projectId.firebaseio.com/users/${user.uid}.json');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.parser(user, json.decode(response.body));
    } else {
      throw response.statusCode;
    }
  }
}
