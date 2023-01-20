import 'dart:io';

import 'package:dummy_assignment/data/model/user_model.dart';
import 'package:dummy_assignment/data/service/user_repository_service.dart';
import 'package:dummy_assignment/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  UserRepositoryService userRepositoryService = UserRepositoryService();
  UserModel userModel = UserModel();
  String email = "error@gmail.com";
  userModel.setEmail(email);
  userModel.setPassword("123456");
  test("Fetch Api", () async {
    var isAuthorized =
        (await userRepositoryService.authenticateUser(userModel));

    expect(false, isAuthorized);
  });
}
