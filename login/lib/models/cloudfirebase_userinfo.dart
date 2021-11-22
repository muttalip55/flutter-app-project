import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CloudFirestore {
  late final String userid;
  late final String fullname;
  final String avatarURL = "";
  late final String email;
  CloudFirestore();

  createUserData(String userid, String fullname, String email) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("userinfo").doc(userid);
    Map<String, String> userInfoList = {
      "avatarURL": avatarURL,
      "email": email,
      "fullname": fullname,
      "userid": userid,
    };
    documentReference
        .set(userInfoList)
        .whenComplete(() => print("print stored successfully"));
  }

  updateUserAvatar(String avatarURL,String userid){
    FirebaseFirestore.instance.collection("userinfo").doc(userid).update({"avatarURL": avatarURL});
    return Container();
  }

  updateUserName(String fullname,String userid){
    FirebaseFirestore.instance.collection("userinfo").doc(userid).update({"fullname": fullname});
    return Container();
  }

}
