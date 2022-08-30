import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  bool selectedEmail = false;
  bool selectedPwd = false;
  String? email;
  String? pwd;

  void setEmail(String? value) {
    email = value;
    print("Email: $email");
    notifyListeners();
  }

  void setPwd(String? value) {
    pwd = value;
    print("PWD: $pwd");
    notifyListeners();
  }

  void setSelectedEmail(bool value) {
    selectedEmail = value;

    notifyListeners();
  }

  void setSelectedPwd(bool value) {
    selectedPwd = value;
    notifyListeners();
  }
}
