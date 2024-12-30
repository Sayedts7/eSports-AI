import 'dart:async';

import 'package:esports/features/home_ai_analysis/view/card_select_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/common_function.dart';
import '../auth/services/auth_services.dart';
import '../auth/view/login_view.dart';

class SplashServices {
  void isLogin(BuildContext context) async {

    // print('--------------------------');
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? userBlocked = false;
    if (user?.uid != null) {
      Timer(
          const Duration(seconds: 1),
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeScreen())));
    }else{
      Timer(
          const Duration(seconds: 1),
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginView())));
    }
  }
}

