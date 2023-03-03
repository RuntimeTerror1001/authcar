import 'package:auth_car/Repository/Auth%20Repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();

  void registerUser(String email, String password) {
    AuthRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password) {
    AuthRepository.instance.loginWithEmailAndPassword(email, password);
  }

  void logoutUser() {
    AuthRepository.instance.logout();
  }
}
