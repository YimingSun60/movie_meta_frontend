class User{
  User._();
  static String _token = "";

  static String get token => _token;
  static set token(String token) => _token = token;
}