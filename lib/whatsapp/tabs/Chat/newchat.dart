import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class NewChats extends StatefulWidget {
  const NewChats({super.key});

  @override
  State<NewChats> createState() => _NewChatsState();
}

class _NewChatsState extends State<NewChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user')
            .where("uid",isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var userid = snapshot.data!.docs[index]['uid'];
                var username = snapshot.data!.docs[index]['Name'];
                var userphotourl = snapshot.data!.docs[index]['Profile Image'];
                return Container(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: ()async{
                          await FirebaseServices().createChat(username,userid);
                        },
                        leading: CircularProfileAvatar(
                          '',
                          child: Image.network("$userphotourl",fit: BoxFit.fill,),
                          radius: 28,
                        ),
                        title: Text("$username"),
                        subtitle: Text("hi"),
                      ),
                    ],
                  ),
                );
              }
          ):Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
