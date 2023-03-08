import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  void setEmail(String value) => email.value = value;

  void setPassword(String value) => password.value = value;
}