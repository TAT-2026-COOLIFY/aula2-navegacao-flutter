// lib/service/auth_service.dart

import 'dart:convert';
//import 'dart:ffi';
//import 'dart:ffi';

import 'package:aula2_navegacao/models/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String _USERS_KEY = "registred_users";
  static const String _REMEMBERED_USER_KEY = "remembered_user";
  static const String _REMEMBERED_USER_TIMESTAMP_KEY = "  remembered_timestamp";

  Future<void> initDefaultUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userPrefefs = prefs.getString(_USERS_KEY);
    if (userPrefefs == null) {
      final defaultUser = [
        UserDto(username: 'admin', password: 'admin'),
        UserDto(username: 'user', password: 'user'),
      ];
      final defaultUserList = 
        defaultUser.map((user) => user.tojson()).toList();
      await prefs.setString(_USERS_KEY, jsonEncode(defaultUserList));
    }
  }
  Future<bool> authenticate(String username, String password) async {
    final prefes = await SharedPreferences.getInstance();
    final defaultUserList = prefes.getString(_USERS_KEY);
    if (defaultUserList != null) {
      // dynamic = Map<string, dynamic>
      final List<dynamic> defaultUser = jsonDecode(defaultUserList);
      final List<UserDto> users = defaultUser.map((u) => UserDto.fromjson(u)).toList();

      return users.any((u) => u.username == username && u.password  == password);
    }
    return false;
  }

  Future<void> saveRememberUser(String username, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance(); 
    if (rememberMe) {
      await prefs.setString(_REMEMBERED_USER_KEY, username);
      await prefs.setInt(_REMEMBERED_USER_TIMESTAMP_KEY, DateTime.now().microsecondsSinceEpoch);
    } else {
      await prefs.remove(_REMEMBERED_USER_KEY);
      await prefs.remove(_REMEMBERED_USER_TIMESTAMP_KEY);
    }

    
  }
}