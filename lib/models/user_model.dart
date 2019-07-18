import 'dart:convert';

class FirebaseUser {
  /// A Firebase Auth ID token for the authenticated user.
  String token;

  /// The email for the authenticated user.
  String refreshToken;

  /// The number of seconds in which the ID token expires.
  int tokenExpiresIn;

  /// The uid of the authenticated user.
  String uid;

  /// The email for the authenticated user.
  String email;

  FirebaseUser.parser(Map user) {
    token = user['idToken'];
    refreshToken = user['refreshToken'];
    tokenExpiresIn = int.parse(user['expiresIn']);
    email = user['email'];
    uid = user['localId'];
  }
}

class UserModel {
  FirebaseUser firebaseUser;
  UserType userType;
  String name;
  String phoneNum;
  String logoURL;
  String locationURL;

  UserModel.parser(this.firebaseUser, Map user) {
    userType = userTypeFromString(user['userType']);
    name = user['name'];
    if (userType == UserType.User) phoneNum = user['phone'];
    if (userType == UserType.Company) {
      logoURL = user['logo'];
      locationURL = user['location'];
    }
  }

  toJson() {
    return userType == UserType.User
        ? json.encode({
            "name": "$name",
            "phone": "$phoneNum",
            "userType": "$userType",
          })
        : json.encode({
            "name": "$name",
            "logo": "$logoURL",
            "location": "$locationURL",
            "userType": "$userType",
          });
  }
}

enum UserType {
  Company,
  User,
}

UserType userTypeFromString(String text) =>
    UserType.values.firstWhere((e) => e.toString() == "$text");
