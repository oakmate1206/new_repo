import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:status_view/status_view.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName = File(file.path);

      final Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName');

      final UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() async {
        final imageUrl = await storageReference.getDownloadURL();

        // Save the image URL in Firestore
        await FirebaseFirestore.instance.collection('status').add({
          'image_url': imageUrl,
        }).then((value) {
          print("uploaded");
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await _uploadImage();
        },
      ),
      body: Column(
        children:[
        Container(
          padding: EdgeInsets.all(10),
              child: CircleAvatar(

                radius: 39,
                backgroundColor: Colors.black26,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.add_a_photo_rounded),
                ),
              ),
            ),


            StreamBuilder(

              stream:  FirebaseFirestore.instance.collection('status').snapshots(),

              builder: (context, snapshot,){

                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final documents = snapshot.data?.docs;
                return Container(
                  height: MediaQuery.of(context).size.height*0.68,
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: documents?.length,
                    itemBuilder: (context, index) {
                      final imageUrl = documents?[index]['image_url']; // Replace with your field name
                      return  GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image.network(imageUrl),
                            );
                          },));

                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 19,top: 10),
                          alignment: Alignment.centerLeft,
                          child: StatusView(
                                    radius: 30,
                                    spacing: 15,
                                    strokeWidth: 2,
                                    indexOfSeenStatus: 2,
                                    numberOfStatus: 5,
                                    padding: 4,
                                    centerImageUrl: "imageUrl",
                                    seenColor: Colors.grey,
                                    unSeenColor: Colors.red,

                                  ),
                        ),
                      );
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: Image.network(imageUrl),
                      // );
                    },
                  ),
                );
              },
            ),])
      // Column(
      //   children: [
      //     Container(
      //       width: double.infinity,
      //       height: 49,
      //       color: Colors.blueAccent,
      //       // child: ListTile(
      //       //
      //       //   leading: Stack(
      //       //     children:[ CircleAvatar(
      //       //       child: Image.asset("c1.png"),
      //       //     ),
      //       //   Align(
      //       //     alignment: Alignment.bottomRight,
      //       //     child: Icon(Icons.add),
      //       //   )
      //       // ]),
      //       //   title:Text("MY STATUS"),
      //       //   subtitle: Text("top to sdd status update"),
      //       //
      //       // ),
      //     ),
      //     SizedBox(height: 10,),
      //     StatusView(
      //       radius: 30,
      //       spacing: 15,
      //       strokeWidth: 2,
      //       indexOfSeenStatus: 2,
      //       numberOfStatus: 5,
      //       padding: 4,
      //       centerImageUrl: "https://picsum.photos/200/300",
      //       seenColor: Colors.grey,
      //       unSeenColor: Colors.red,
      //
      //     ),
      //   ],
      // ),
    );
  }
}
