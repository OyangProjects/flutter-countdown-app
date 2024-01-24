import 'package:countdown_app/auth/login_page.dart';
import 'package:countdown_app/auth/register_page.dart';
import 'package:flutter/material.dart';

class AuthPageSetter extends StatefulWidget {
  const AuthPageSetter({super.key});

  @override
  State<AuthPageSetter> createState() => _AuthPageSetterState();
}

class _AuthPageSetterState extends State<AuthPageSetter> {

  bool showLoginPage = true;

  void toggleAuthState() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: toggleAuthState,
      );
    } else {
      return RegisterPage(
        onTap: toggleAuthState,
      );
    }
  }
}