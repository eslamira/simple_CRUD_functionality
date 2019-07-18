/// common functions in app
class Common {
  /// making singleton
  static Common _instance = Common.internal();
  Common.internal();
  factory Common() => _instance;

  /// Validating email address
  String emailValidator(String value) {
    if (value.length < 1)
      return 'Can\'t be empty';
    else {
      if (value.length > 3 && value.contains('@') && value.contains('.')) {
        return null;
      } else {
        return 'Wrong Email Address';
      }
    }
  }

  /// Validating password
  String passValidator(String value) {
    if (value.length < 1)
      return 'Can\'t be empty';
    else {
      if (value.length > 6 &&
          value.contains(RegExp('[A-Z]')) &&
          value.contains(RegExp('[a-z]')) &&
          value.contains(RegExp('[1-9]'))) {
        return null;
      } else {
        return 'Please Enter Strong Pass with Letters and Numbers';
      }
    }
  }
}
