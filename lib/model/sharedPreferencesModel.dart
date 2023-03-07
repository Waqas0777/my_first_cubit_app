import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesModel {
  final SharedPreferences prefs;
  SharedPreferencesModel(this.prefs);

  void setLoginStatus(bool value) {
    prefs.setBool("loginStatus", value);
  }

  bool getLoginStatus() {
    return prefs.getBool("loginStatus") ?? false;
  }

  void setUserName(String value) {
    prefs.setString("userName", value);
  }

  String getUserName() {
    return prefs.getString("userName") ?? "";
  }

  void setUserEmail(String value) {
    prefs.setString("userEmail", value);
  }

  String getUserEmail() {
    return prefs.getString("userEmail") ?? "";
  }

  void setUserPassword(String value) {
    prefs.setString("password", value);
  }

  String getUserPassword() {
    return prefs.getString("password") ?? "";
  }
}
