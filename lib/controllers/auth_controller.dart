import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_clone/services/supabase_manager.dart';

class AuthController extends GetxController {
  final client = SupabaseManager.supabaseClient.auth;
  var isLogged = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    isLogged.value = isLoggedIn;
    if (isLoggedIn) {
      Get.offAllNamed('/nav');
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> login() async {
    try {
      final email = emailController.text;
      final password = passwordController.text;

      final response =
          await client.signInWithPassword(email: email, password: password);

      final Session? session = response.session;
      final User? user = response.user;
      if (session != null && user != null) {
        isLogged.value = true;
        log('User ${user.email} logged in successfully!');
        Get.offAllNamed('/nav');

        //save login state
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', user.email!);
      } else {
        Get.snackbar(
          'Error',
          'Login Failed',
          animationDuration: const Duration(milliseconds: 500),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        animationDuration: const Duration(milliseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
