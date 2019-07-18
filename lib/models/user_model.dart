class UserModel {
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
}
