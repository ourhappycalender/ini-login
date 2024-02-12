import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/homepage.dart';
import 'package:flutter_tim/screens/welcome/componen/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key})
      : super(key: key); 

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn() {
      bool userLoggedIn = false;
      return userLoggedIn;
    }

    return isUserLoggedIn() ? const HomePage() : const WelcomeScreen();
  }
}
