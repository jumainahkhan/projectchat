import 'package:flutter/material.dart';

class Authenticate {
  static authenticateUser(username, password) {
    if (username == 'saif' && password == 'jum') {
      return true;
    } else {
      return false;
    }
  }
}
