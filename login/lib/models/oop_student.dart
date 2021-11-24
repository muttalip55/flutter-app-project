import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Student{
 late String id ;
 late String firstName;
 late String lastName;
 late String grade;
 late String avatarURL;
 Student();

  createStudentData(String tc, String firstName, String lastName,String grade,String avatarURL) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("students").doc(tc);
    Map<String,String> studentList = {
      "avatarURL": avatarURL,
      "FirstName": firstName,
      "LastName": lastName,
      "grade": grade,
      "tc": tc,
    };
    documentReference
        .set(studentList)
        .whenComplete(() => print("print stored successfully"));
  }

 updateUser(String tc, String firstName, String lastName,String grade,String avatarURL){
   FirebaseFirestore.instance.collection("students").doc(tc).update({"tc" : tc,"FirstName":firstName,"LastName": lastName,"grade" : grade,"avatarURL": avatarURL});
 }

 deleteUser(String tc){
   FirebaseFirestore.instance.collection("students").doc(tc).delete();
 }
}