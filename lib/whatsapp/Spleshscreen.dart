import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';


import '../flutter_notes_app_firebase/Welcome.dart';
class Spleshscreen1 extends StatefulWidget {
  const Spleshscreen1({super.key});

  @override
  State<Spleshscreen1> createState() => _Spleshscreen1State();
}

class _Spleshscreen1State extends State<Spleshscreen1> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds:3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
    });
    return Scaffold(
      body: Center(child: Image.network("https://static.whatsapp.net/rsrc.php/v3/yR/r/y8-PTBaP90a.png")),
    );
  }
}
