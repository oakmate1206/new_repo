import 'dart:async';

import 'package:all_implementations/flutter_notes_app_firebase/home_screen.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
    return Scaffold(
      body: Center(child: Image.asset("assets/images/notes.png")),
    );
  }
}