import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import 'Chat/chatscreen_inbox.dart';
import 'Chat/newchat.dart';
// import 'package:wechat/chatScreen.dart';
// import 'package:wechat/newChats.dart';
// import 'package:wechat/services/firebase_services.dart';
class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xff401D9A),
        //   leadingWidth: 250,
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 18.0,top: 8),
        //     child: Text("WeChat",style: TextStyle(
        //       fontSize: 30,
        //       fontWeight: FontWeight.w600,
        //       color: Colors.white,
        //     ),),
        //   ),
        //   actions: [
        //     Icon(Icons.wifi,color: Colors.white,size: 30,),
        //     SizedBox(width: 15,),
        //     Icon(Icons.dark_mode,color: Colors.white,size: 30,),
        //     SizedBox(width: 15,),
        //     Icon(Icons.search,color: Colors.white,size: 30,),
        //     SizedBox(width: 15,),
        //     Icon(Icons.more_vert,color: Colors.white,size: 30,),
        //     SizedBox(width: 8,),
        //   ],
        // ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:  FirebaseFirestore.instance.collection(FirebaseServices().chatCollection)
                    .where("type",isEqualTo: "1-1").where("users",arrayContains: user.uid).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> asyncSnapshot) {


                  return   asyncSnapshot.hasData? ListView.builder(
                      itemCount: asyncSnapshot.data!.docs.length,
                      itemBuilder: (context,index) {
                        var chat = asyncSnapshot.data!.docs[index].data();
                        var chatId = asyncSnapshot.data!.docs[index].id;
                        return ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(chatId: chatId,)));
                          },
                          leading: Image.network('https://iheartcraftythings.com/wp-content/uploads/2022/01/6-24.jpg'),
                          title: Text("${chat["users"][0]==user.uid?chat["name"].toString().split("_").last
                              :chat["name"].toString().split("_").first}"),
                          subtitle: Text("${chat["lastMessage"]}"),
                        );
                      }
                  ):

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          )),
                    ),
                  );
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0,left: 250),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FloatingActionButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewChats(),));
                },
                  backgroundColor: Colors.blue[900],
                  child: Icon(Icons.add,color: Colors.white,size: 40,weight: 30,),
                ),
              ),
            )
          ],
        )
    );
  }
}
