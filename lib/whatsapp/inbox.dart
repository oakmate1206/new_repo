import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';


class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();
  final auth = FirebaseAuth.instance;


  void _sendMessage(String text) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('messages').add({
        'text': text,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    _messageController.clear();
  }


  @override
  Widget build(BuildContext context) {
    var _changeSeek;
    var _playAudio;
    return Scaffold(
        backgroundColor: Colors.white,//Color(0xffff7578),
        body: Stack(
          children: [
            Align(alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Color(0xffff7578),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(23),bottomRight: Radius.circular(23))
                ),

                child: Container(
                  color: Color(0xffff7578),
                  margin: EdgeInsets.symmetric(vertical: 27),
                  width: double.infinity,
                  child: ListTile(
                    leading: InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                        },
                        child: Image.asset("assets/c1.png")),
                    title: Text(
                      "${    auth.currentUser!.displayName.toString()
                      }",

                      style: GoogleFonts.getFont("Inter", color: Colors.white),
                    ),
                    subtitle: Text(
                      "Online",
                      style: GoogleFonts.getFont("Inter", color: Colors.white54),
                    ),
                    trailing: Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align( alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 10,bottom: 0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Colors.white),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('messages')
                      .orderBy('timestamp')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }


                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final messages = snapshot.data!.docs;
                    final currentUser = _auth.currentUser;

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final messageText = message['text'];
                        final messageUserId = message['userId'];
                        final isCurrentUser = currentUser?.uid == messageUserId;

                        return BubbleSpecialThree(
                            text: messageText,
                            color: isCurrentUser
                                ? Color(0x40FF8933)
                                : Color(0x40FFC700),
                            tail: isCurrentUser ? false : true,
                            isSender: isCurrentUser ? true : false,
                            textStyle: TextStyle(
                              color: Colors.black,
                            ));
                      },
                    );
                  },
                ),
              ),
            ),
            Align(alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height*0.08,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2,color: Colors.grey),
                  borderRadius: BorderRadius.circular(33),

                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.add_circle_rounded,color: Colors.pinkAccent,),
                    SizedBox(width: 4,),
                    Expanded(
                      child: TextFormField(

                        controller: _messageController,

                        decoration:
                            InputDecoration(hintText: 'Type message...',
                              border: InputBorder.none
                            ),


                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.schedule_send_sharp,color: Colors.pinkAccent,),
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          _sendMessage(_messageController.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
