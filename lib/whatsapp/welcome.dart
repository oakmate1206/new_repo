import 'package:flutter/material.dart';

import 'login.dart';

class Welcome2 extends StatefulWidget {
  const Welcome2({super.key});

  @override
  State<Welcome2> createState() => _Welcome2State();
}

class _Welcome2State extends State<Welcome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc71586),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRatQfJ-KjFW11RyUsSh1WNQajTHV865z2WTA&usqp=CAU"),
          )
          ,Container(
            margin: EdgeInsets.only(top: 170,right: 30,left: 30),
            alignment: Alignment.topCenter,

            child: Column(
              children: [
                Center(child: Text("Welcome to Whatsapp",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 23,color: Colors.white),)),
                Center(child: Text("Read Our Privacy Policy.Tap ' Agree amd Continue' to accept the TERMS OF SERVICES",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.white70),))
              ],
            ),
          ),
          InkWell( onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>pg2()));
          },
            child: Container(
                margin: EdgeInsets.only(top: 33,bottom: 10,right: 23,left: 23),
                alignment: Alignment.center,
                width: 384,height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xFFFF7578)
                ),
                child:  Center(child: Text("Sign In",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),))
            ),
          ),
          Container(width: MediaQuery.of(context).size.width*0.8,height: 24,
            margin: EdgeInsets.only(right: 0,top: 15),
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Center(
              child: Row(
                children: [
                  Text("Don’t have an account?",style: TextStyle(fontSize: 13),),
                 // Text("Sign Up",style: TextStyle(fontSize: 13,color: Color(0xFFFF7578)),),

                ],
              ),
            ),
          ),
          InkWell(onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
          },
            child: Container(
                margin: EdgeInsets.only(top: 3,bottom: 20,right: 23,left: 23),
                alignment: Alignment.center,
                width: 384,height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xFFFF7578)
                ),
                child:  Center(child: Text("Sign Up",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),))
            ),
          ),


        ],
      ),
    );
  }
}
