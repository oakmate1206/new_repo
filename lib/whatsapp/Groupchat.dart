import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'inbox.dart';

class Groupschats extends StatefulWidget {
  const Groupschats({super.key});

  @override
  State<Groupschats> createState() => _GroupschatsState();
}

class _GroupschatsState extends State<Groupschats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell( onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Inbox()));
    },
      child: Container( height: 70,
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.personal_injury_sharp),
          ),
          title: Text("Flutter Course B-8",style: GoogleFonts.getFont("Inter"),),
          subtitle: Text("Okay sure!!",style: GoogleFonts.getFont("Inter",color: Colors.grey),),
          trailing: Column(
            children: [
              Text("12:38 PM",style: GoogleFonts.getFont("Inter",color: Colors.grey),),
              SizedBox(height: 10,),
              Image.asset("assets/tick.png",color: Colors.black,)
            ],
          ),
        ),
      ), )
        ],
      ),
    );
  }
}
