import 'dart:convert';

import 'package:sentinela/app/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedUserService {
  final Future<SharedPreferences> pref;
  SharedUserService({required this.pref});

  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await pref;
    String userJson = prefs.getString("user") ?? "";
    if (userJson.isNotEmpty) {
      Map<String, dynamic> userListMap = json.decode(userJson);
      UserModel userModel = UserModel.fromMap(userListMap);

      return userModel;
    }
    return null;
  }

  Future<void> saveUser(UserModel user) async {
    SharedPreferences prefs = await pref;
    String userJson = user.toJson();
    await prefs.setString('user', userJson);
    return;
  }

  Future<bool> checkExistUser() async {
    final userSearch = await getUser();
    if (userSearch == null) {
      return false;
    } else {
      return true;
    }
  }
}
