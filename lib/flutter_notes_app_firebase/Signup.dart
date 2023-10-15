import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'LoginPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool scure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formlKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formlKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                height: 240,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      "Welcome! to Notes App",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70, right: 90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign Up to your \n Account",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              wordSpacing: -2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
              ),
              Container(
                height: 60,
                width: 320,
                margin: EdgeInsets.only(right: 10, left: 10),
                child: TextFormField(
                  controller: email,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    suffixText: "@gmail.com",
                    prefixIcon: Icon(Icons.email),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00689C)),
                    ),
                    hintText: "Enter Email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.only(left: 20, right: 30),
                  ),
                  validator: (val) {
                    return val!.contains("@")
                        ? null
                        : "Please enter valid email";
                  },
                ),
              ),
              Container(
                height: 75,
                width: 320,
                margin: EdgeInsets.only(right: 10, left: 10),
                child: TextFormField(
                  controller: password,
                  obscureText: scure,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00689C)),
                    ),
                    hintText: "Enter Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            scure = !scure;
                          });
                        },
                        icon: Icon(
                            scure ? Icons.visibility : Icons.visibility_off)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.only(left: 20, right: 30),
                  ),
                  validator: (val) {
                    return val!.isNotEmpty && val.length >= 6
                        ? null
                        : "Enter password greater then or equal to 6 digit";
                  },
                ),
              ),
              InkWell(
                onTap: () async {

                  if (formlKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email.text, password: password.text);
                    } on FirebaseAuthException catch (e) {
                      print(e.toString());

                      if (e.toString().contains("email-already-in-use")) {
                        Fluttertoast.showToast(
                            msg: "Account already Exist",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()));
                    } catch (e) {}
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff00689C),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 20),
                child: Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    "OR Register with",
                    style: TextStyle(
                      color: Color(0xff00689C),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Divider()),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 60),
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: InkWell(
                          onTap: () async {
                            final GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signIn();

                            print(googleUser!.email);
                            print(googleUser!.displayName);
                            print(googleUser!.id);
                            print(googleUser!.photoUrl);

                            // Obtain the auth details from the request
                            final GoogleSignInAuthentication? googleAuth =
                            await googleUser?.authentication;

                            // create a new credential

                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth?.accessToken,
                              idToken: googleAuth?.idToken,
                            );
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithCredential(credential);
                            User? user = userCredential.user;
                            if (user != null) {
                              DocumentSnapshot documentSnapshot =
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(user.uid)
                                  .get();
                              if (documentSnapshot.exists) {
                                print("");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              } else {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user.uid)
                                    .set({
                                  "uid": user.uid,
                                  "name": user.displayName,
                                  "profileImage": user.photoURL,
                                  "email": user.email,
                                  "createdAt": DateTime.now(),
                                  "updatedAt": DateTime.now(),
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://w7.pngwing.com/pngs/326/85/png-transparent-google-logo-google-text-trademark-logo-thumbnail.png",
                                height: 25,
                                width: 25,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Container(
                      width: 15,
                    ),
                    Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://w7.pngwing.com/pngs/282/704/png-transparent-facebook-messenger-logo-icon-facebook-facebook-logo-blue-text-trademark-thumbnail.png",
                              height: 25,
                              width: 25,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Facebook",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 0, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Already have an Account?  ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Container(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xff00689C),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
