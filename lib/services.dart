// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// getAll()async{
//   return await FirebaseFirestore.instance.collection(notesCollection).get();
// }
// getSpecific(String docId)async{
//   return await FirebaseFirestore.instance.collection(notesCollection).doc(docId).get();
// }
// getByCondition()async{
//   return await FirebaseFirestore.instance.collection(notesCollection).where("user",isEqualTo:FirebaseAuth.instance.currentUser!.uid).get();
// }
// getAndFilterByUser()async{
//   return await FirebaseFirestore.instance.collection(notesCollection)
//       .where("users",arrayContains:FirebaseAuth.instance.currentUser!.uid).get();
// }
// getByOrder()async{
//   return await FirebaseFirestore.instance.collection(notesCollection).orderBy("createdAt",descending: true).get();
// }
// addNotes(title,body)async{
//   await FirebaseFirestore.instance.collection(notesCollection).doc().set(
//       {
//         "title":title,
//         "body":body,
//         "createdAt":DateTime.now(),
//         "uid":FirebaseAuth.instance.currentUser!.uid,
//       });
// }
// // text,image,video,voice, sticker
// addMessage(title,type,chatRoomId)async{
//   await FirebaseFirestore.instance.collection(notesCollection).doc().set(
//       {
//         "text":title,
//         "type":type,
//         "chatRoom":chatRoomId,
//         "createdAt":DateTime.now(),
//         "uid":FirebaseAuth.instance.currentUser!.uid,
//       });
// }
// updateNotes(String docId,title,body)async{
//   await FirebaseFirestore.instance.collection(notesCollection).doc(docId).update(
//       {
//         "title":title,
//         "body":body,
//       });
// }
// deleteNotes(String docId)async{
//   await FirebaseFirestore.instance.collection(notesCollection).doc(docId).delete();
// }