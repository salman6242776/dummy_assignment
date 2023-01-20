class UserModel {
  late String _email;
  late String _password;

  UserModel();

// #region Getters
  String get email => _email;

  String get password => _password;
// #endregion

// #region Setters
  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

// #endregion

}
