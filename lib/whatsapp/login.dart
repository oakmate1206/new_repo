// import 'package:dogsapp/tabbar.dart';


import 'package:all_implementations/whatsapp/tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';



class pg2 extends StatefulWidget {
  const pg2({super.key});

  @override
  State<pg2> createState() => _pg2State();
}

class _pg2State extends State<pg2> {
  TextEditingController controller =TextEditingController();

  bool scure = true;
  TextEditingController email = TextEditingController();
 // TextEditingController username = TextEditingController();
//  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey =   GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 343,height:135,
              color: Colors.transparent,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top:20 ,right: 30,left: 30),
              child: Stack(
                children: [
                  Image(image: AssetImage("assets/v3.png")),


                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,

              child: Text("Welcome Back! ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color(0xFFFF7578)),),
            ),
            SizedBox(height: 10,),
            Container(
              width: 384,height: 100,
              margin: EdgeInsets.only(left: 15,right: 15),
              color: Colors.transparent,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,

                    child: Text("    Email",style: TextStyle(color: Colors.black38),),
                  ),
                  TextFormField(
                    controller: email,


                    // onChanged: (value)=>didUpdateWidget(src()),
                    decoration: InputDecoration(

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2)
                      ),

                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white,width: 1),
                      ),
                      hintText: "iwuy212@gmail.com",
                      hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),


                    ),
                    validator: (val){
                      return val!.contains("@")?null:"please enter correct email";

                    },

                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 384,height: 100,
              margin: EdgeInsets.only(left: 15,right: 15),

              color: Colors.transparent,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,

                    child: Text("    Password",style: TextStyle(color: Colors.black38),),
                  ),
                  TextFormField(
                    controller: password,
                    validator: (val){
                      return val!.isNotEmpty && val.length>6?null:"please enter correct password 0r greater then 6";

                    },


                    // onChanged: (value)=>didUpdateWidget(src()),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white,width: 1),
                      ),
                      hintText: "  *******",
                      hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                    ),
                  ),

                ],
              ),
            ),
            Container(width: MediaQuery.of(context).size.width*0.9,height: 20,
            margin: EdgeInsets.only(right: 22,top: 25),
            color: Colors.transparent,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text("Forgot Password?",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w400),)),
            ),
            InkWell( onTap:()async {
    if(formkey.currentState!.validate()){
    try{
    UserCredential useCredential =    await FirebaseAuth.instance.signInWithEmailAndPassword
    (email: email.text, password: password.text);

    User? user  = useCredential.user;
    if(user!=null){
    print(user.email);
    email.text = "";
    password.text = "";
    // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));


    setState(() {
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));

    });
    // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));

    }
    }
    on FirebaseAuthException catch(e){
    print(e.toString());

    if(e.toString().contains("wrong-password")){
    Fluttertoast.showToast(
    msg: "Password wrong",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
    );
    }else
      {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));

      }

    } catch(e){
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));

    }                }


            },
              child: Container(
                margin: EdgeInsets.only(top: 33,bottom: 20,right: 23,left: 23),
                alignment: Alignment.center,
                width: 384,height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xFFFF7578)
                ),
                child:  Center(child: Text("Sign In",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),))
              ),
            ),
            Text("${FirebaseAuth.instance.currentUser==null?"User Not Login":FirebaseAuth.instance.currentUser!.uid}"),
            Text("${FirebaseAuth.instance.currentUser==null?"User Not Login":FirebaseAuth.instance.currentUser!.email}"),
            Container(
              width: 260,
              height: 50,
              margin: EdgeInsets.only(left: 26,right: 26),
              color: Colors.transparent,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Container(
                    //   width: 80,
                    //   height: 49,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(width: 2,color: Color(0xFFFF7578)),
                    //     borderRadius: BorderRadius.circular(20),
                    //
                    //   ),
                    //   child: ImageIcon(AssetImage()),
                    // )
                    InkWell(
                        onTap: ()async{
                          final GoogleSignInAccount? googleuser =await  GoogleSignIn().signIn();
                          //
                          // print(googleuser!.email);
                          // print(googleuser!.displayName);
                          // print(googleuser!.id);
                          // print(googleuser!.photoUrl);

                          final  GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;
                          final credential =GoogleAuthProvider.credential(
                            accessToken: googleAuth?.accessToken,
                            idToken: googleAuth?.idToken,
                          );
                          UserCredential usercredential =await FirebaseAuth.instance.signInWithCredential(credential);
                          User? user = usercredential.user;
                          if(user!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TabbarScreen()));

                            DocumentSnapshot docurntsnapshot =await FirebaseFirestore.instance.collection("user").doc(user.uid).get();
                          if(docurntsnapshot.exists){
                            print(" ");
                          }else{
                            await FirebaseFirestore.instance.collection("user").doc(user.uid).set(
                                {

                                  "uid":user.uid,
                                  "Name":user.displayName,
                                  "email":user.email,
                                  "Profile Image":user.photoURL,
                                  "CreateAt":DateTime.now(),
                                  "UploadAt":DateTime.now(),


                                  } as Map<String, dynamic>);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TabbarScreen()));
                          }

                          }



                        },

                        child: Image.asset("assets/v5.png")),
                    SizedBox(width: 9,),
                    Image.asset("assets/v4.png"),
                    SizedBox(width: 9,),
                    Image.asset("assets/v3.png"),

                  ],
                ),
              ),

            ),

                Container(width: 200,height: 24,
                  margin: EdgeInsets.only(right: 0,top: 15),
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Center(
                    child: Row(
                      children: [
                        Text("Don’t have an account?",style: TextStyle(fontSize: 12),),
                        Text("Sign Up",style: TextStyle(fontSize: 12,color: Color(0xFFFF7578)),),

                      ],
                    ),
                  ),
                ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset("assets/v6.png"),
            ),






          ],
        ),
      ),
    );
  }
}
