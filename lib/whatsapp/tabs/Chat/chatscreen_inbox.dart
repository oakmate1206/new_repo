import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:image_picker/image_picker.dart';


// import 'package:wechat/services/firebase_services.dart';


class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final FirebaseFirestore firebaseMessageUserId = FirebaseFirestore.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageC = TextEditingController();

  TextEditingController messages3 = TextEditingController();
  final ImagePicker _picker = ImagePicker();
   String imageUrl="";
  Future<void> _uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName = File(file.path);

      final Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName');

      final UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() async {
         imageUrl = await storageReference.getDownloadURL();
         print(imageUrl);
         await FirebaseServices().createMessage(widget.chatId, messages3.text,imageUrl:imageUrl.toString() ).then((value) => messages3.clear());

        //  await FirebaseFirestore.instance.collection('messages3').doc().update({
        //   'imageUrl': imageUrl,
        // });
        // Save the image URL in Firestore
        // await FirebaseFirestore.instance.collection('chatimages').add({
        //   'image_url': imageUrl,
        // }).then((value) {
        //   print("uploaded");
        // });
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("Name"),
        ),
      ),
      body:
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('messages3').
                 where("chatId",isEqualTo: widget.chatId).orderBy("createdAt",descending: true).snapshots(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    // final documents = snapshot.data?.docs;

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length ,
                      reverse: true,
                      itemBuilder: (context, index) {
                        // final imageUrl = documents?[index]['image_url']; // Replace with your field name

                        String uidfromfirebase = snapshot.data!.docs[index]["senderId"];
                        if(snapshot.data!.docs[index]["text"] !="") {

                        if (FirebaseAuth.instance.currentUser!.uid == uidfromfirebase) {
                          return
                            BubbleNormal(
                              text: snapshot.data!.docs[index]["text"],
                              isSender: true,
                              color: Color(0xFF1B97F3),
                              tail: true,
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            );
                        }
                        else {
                          return
                            BubbleNormal(
                              text: snapshot.data!.docs[index]["text"],
                              isSender: false,
                              color: Colors.tealAccent,
                              tail: false,
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            );
                        }

                      }
                        else if( snapshot.data!.docs[index]["imageUrl"] != ""){
                          print(snapshot.data!.docs[index]["imageUrl"].toString());
                          return
                            BubbleNormalImage(
                            id: 'id001',
                            image:  Image.network(snapshot.data!.docs[index]["imageUrl"].toString()),
                            color: Colors.purpleAccent,
                            tail: true,
                            delivered: true,
                          );

                        }
                        },);
                  }
              ),),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.1,
              child: Container(
                  margin: EdgeInsets.only(left: 10,right: 5),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(right: 5 ),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(

                          controller: messages3,
                          decoration: InputDecoration(
                            prefixIcon: GestureDetector(
                                onTap: ()async{
                                  await _uploadImage();


                                },
                                child: Icon(Icons.add_circle_outline_outlined)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                            hintText: "Message",
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()async {
                          if(messages3!=null) {
                            await FirebaseServices().createMessage(widget.chatId, messages3.text,imageUrl:imageUrl.toString() ).then((value) => messages3.clear());
                          }
                        },
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.14,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Icon(Icons.send,size: 20,color: Colors.white,)),
                      ),
                    ],
                  )

              ),
            )
          ],
        ),
      ),
    );
  }
}