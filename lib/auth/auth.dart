import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isUserSignedIn = false;
  bool get isUserSignedIn => _isUserSignedIn;

  Future<bool> getSignInInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isUserSignedIn") ?? false;
  }

  void updateSignedInInfo(bool isSignedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isUserSignedIn", isSignedIn);
    _isUserSignedIn = isSignedIn;
    notifyListeners();
  }
}
