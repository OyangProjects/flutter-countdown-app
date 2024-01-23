import 'package:countdown_app/auth/login_button.dart';
import 'package:countdown_app/auth/login_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void loginTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              // Header

              const SizedBox(height: 50,),

              const Icon(
                Icons.alarm_add_rounded,
                size: 100,
          
              ),

              const Text("Welcome back!"),

              const SizedBox(height: 50,),

              // Login Textfields
      
              LoginTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 25,),

              LoginTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              // Forgot Password Option


              // Login Button

              const SizedBox(
                height: 25,
              ),

              LoginButton(
                onTap: loginTap
              ),

              // Other Sign in Options

              const Divider(
                thickness: 0.5,
                color: Colors.red,
              ),

          
            ],
          ),
        ),
      ),
    );
  }
}