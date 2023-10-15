import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // boxShadow:
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            doc["creation_date"],
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),

          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            doc["note_content"],
            style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
