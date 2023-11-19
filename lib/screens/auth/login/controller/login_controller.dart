import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final isPasswordNotVisible = true.obs;


  togglePasswordVisibility() {
    isPasswordNotVisible.value = !isPasswordNotVisible.value;
  }
}
