import 'package:agtech/src/data/database.dart';
import 'package:agtech/src/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserController {
  UserEntity? user;

  Future<void> login(UserEntity user) async {
    final db = DB.instance;

    final result = await db.login(user);

    if (result != null) {
      this.user = result;
    } else {
      this.user = null;
    }
  }

  Future<bool> signUp(UserEntity user) async {
    final db = DB.instance;

    final result = await db.signUp(user);

    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    user = null;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
