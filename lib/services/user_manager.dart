import 'dart:convert';

import 'package:name_badge/models/user.dart';
import 'package:name_badge/services/key-list.dart';
import 'package:name_badge/services/storage-manager.dart';

class UserManager {
  Future<User?> getUser() async {
    var user = await StorageManager.readData(USER);
    if (user != null) {
      var json = jsonDecode(user);
      return User.fromJson(json);
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    await StorageManager.saveData(USER, jsonEncode(user.toJson()));
  }
}
