import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  static late SharedPreferences _prefs;

  reset() {
    log("==============shared prefs cleared===============");
    _prefs.clear();
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
    log("====================shared preference instance created===================");
  }

  static clearRememberMe() {
    _prefs.remove("rememberMe");
    log("==============remember me cleared===============");
  }

  static clearCurrentWorkProfile() {
    _prefs.remove("workProfile");
    log("==============work profile cleared===============");
  }

  static getRememberMe() {
    return _prefs.getBool("rememberMe") ?? false;
  }

  static getUserId() {
    return _prefs.getString("userId") ?? "";
  }

  static getEmailId() {
    return _prefs.getString("emailId") ?? "";
  }

  static getUsername() {
    return _prefs.getString("username") ?? "";
  }

  static getAccountStatus() {
    return _prefs.getInt("accountStatus") ?? 2;
  }

  static getToken() {
    return _prefs.getString("token");
  }

  static getCurrentWorkProfile() {
    return _prefs.getString("workProfile");
  }

  void setRememberMe(bool rememberMe) {
    _prefs.setBool("rememberMe", rememberMe);
    log("rememberMe set=======");
  }

  Future<void> setUserId(String id) async {
    await _prefs.setString("userId", id);
    log("userId set=======");
  }

  void setEmailId(String email) {
    _prefs.setString("emailId", email);
    log("emailId set=======");
  }

  void setUsername(String username) {
    _prefs.setString("username", username);
    log("username set=======");
  }

  void setAccountStatus(int accountStatus) {
    _prefs.setInt("accountStatus", accountStatus);
    log("accountStatus set=======");
  }

  Future<void> setToken(String? token) async {
    if (token == null) {
      _prefs.remove("token");
      return;
    }
    await _prefs.setString("token", token);
    log("token set=======");
  }

  Future<void> setCurrentWorkProfile(String workProfile) async {
    await _prefs.setString("workProfile", workProfile);
    log("workProfiles set=======");
  }
}
