import 'package:devis_social_shop/screens/catalog_screen.dart';
import 'package:devis_social_shop/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CatalogScreen();
          }else{
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
