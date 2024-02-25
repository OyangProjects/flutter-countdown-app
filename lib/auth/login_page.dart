import 'package:countdown_app/auth/login_button.dart';
import 'package:countdown_app/auth/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {

  final Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
            
                // Header
            
                const Icon(
                  Icons.alarm_add_rounded,
                  size: 100,
            
                ),
            
                const Text("Welcome to Name of App"),
            
                const SizedBox(height: 50,),
            
                // Login Textfields
                  
                LoginTextField(
                  controller: emailController,
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
                  onTap: signUserIn,
                  buttonText: 'Sign In',
                ),
            
                // Other Sign in Options

                const SizedBox(
                  height: 10.0,
                ),
            
                const Divider(
                  thickness: 1.0,
                  color: Colors.black,
                  indent: 5.0,
                  endIndent: 5.0,
                ),
            
                const SizedBox(
                  height: 10.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?'
                    ),
                    const SizedBox(width: 4.0),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),


            
              ],
            ),
          ),
        ),
      ),
    );
  }
}