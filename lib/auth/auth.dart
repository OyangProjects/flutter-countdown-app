import 'package:countdown_app/auth/auth_page_setter.dart';
import 'package:countdown_app/presentation/nav_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends StatelessWidget {
  const AuthController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavigationPage();
          } else {
            return const AuthPageSetter();
          }
        }
      ),
    );
  }
}