import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Add a new Note', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
        actions: [
          IconButton(onPressed: (){
            FirebaseFirestore.instance.collection("Notes").add({
          "note_title": _titleController.text,
          "creation_date":date,
          "note_content":_mainController.text,
        }).then((value) {
          print(value.id);
          Navigator.pop(context);
        }).catchError((error) =>  print("Failed to add new Note due to $error"));
        },
          icon: Icon(Icons.save),)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title'
              ),
              style:TextStyle(fontSize: 28,fontWeight: FontWeight.bold) ,
            ),
            SizedBox(height: 8.0,),
            Text(date,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 28.0,),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),

    );
  }
}
