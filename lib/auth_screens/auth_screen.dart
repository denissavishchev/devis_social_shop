import 'package:devis_social_shop/auth_screens/login_screen.dart';
import 'package:devis_social_shop/auth_screens/register_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool showLoginScreen = true;

  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(registerPage: toggleScreens);
    }else {
      return RegisterScreen(loginPage: toggleScreens,);
    }
  }
}
