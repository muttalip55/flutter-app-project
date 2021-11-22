import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/models/cloudfirebase_userinfo.dart';
import 'package:login/validation/validatior.dart';
import 'package:login/widgets/appbar_widget.dart';

class UserEditWidget extends StatefulWidget {
  const UserEditWidget({Key? key, required this.userid}) : super(key: key);
  final String userid;

  @override
  _UserEditWidgetState createState() => _UserEditWidgetState(userid);
}

class _UserEditWidgetState extends State<UserEditWidget> {
  late final String userid;
  XFile? selectedFile;
  final ImagePicker _picker = ImagePicker();
  String _selectedFileName = "";
  String uploadPath = "";
  bool LoadImg = false;
  final _formKey = GlobalKey<FormState>();

  _UserEditWidgetState(this.userid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget("Profil Edit"),
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("userinfo").get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot> arrData = snapshot.data!.docs;
                return ListView(
                  children: arrData.map((data) {
                    return Card(
                      child: Column(
                        children: [
                          if (userid == data["userid"])
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15.0)),
                                    LoadImg
                                        ? CircularProgressIndicator()
                                        : data["avatarURL"] != ""
                                            ? Image(
                                                image: NetworkImage(
                                                    data["avatarURL"]),
                                              )
                                            : uploadPath != ""
                                                ? Image(
                                                    image: NetworkImage(
                                                        data["avatarURL"]),
                                                  )
                                                : Image.asset(
                                                    "assets/images/notfound.png",
                                                    height: 150,
                                                    width: 150,
                                                    fit: BoxFit.fitWidth,
                                                  )
                                  ],
                                ),
                                uploadPath == ""
                                    ? Container()
                                    : CloudFirestore()
                                        .updateUserAvatar(uploadPath, userid),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15.0)),
                                    const Expanded(
                                        child: Text(
                                      "Name",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(child: Text(data["fullname"])),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 20.0)),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15.0)),
                                    const Expanded(
                                        child: Text(
                                      "Email",
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(child: Text(data["email"])),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlineButton(
                                      onPressed: () {
                                        SelectedFile();
                                      },
                                      child: Text("Select Image"),
                                    ),
                                    OutlinedButton.icon(
                                        onPressed: () {
                                          uploadFile(selectedFile!);
                                        },
                                        icon: Icon(Icons.cloud_upload),
                                        label: Text("Upload")),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _selectedFileName == ""
                                    ? Container(child: Text(_selectedFileName))
                                    : Text("File Name :" + _selectedFileName),
                              ],
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          UserInfoEditForm(userid: userid,),
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: Text("No data Found"),
                );
              }
            }),
      ),
    );
  }

  Future<void> uploadFile(XFile file) async {
    String uploadFileName = "avatar1.jpg";
    Reference reference =
        FirebaseStorage.instance.ref().child(userid).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(file.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        LoadImg = true;
      });
    });

    await uploadTask.whenComplete(() async {
      uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        LoadImg = false;
      });
    });
  }

  Future<void> SelectedFile() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedFile = img;
      _selectedFileName = img!.name.toString();
    });
  }
}

class UserInfoEditForm extends StatefulWidget {
  const UserInfoEditForm({Key? key, required this.userid}) : super(key: key);
  final String userid;
  @override
  _UserInfoEditFormState createState() => _UserInfoEditFormState(userid);
}

class _UserInfoEditFormState extends State<UserInfoEditForm>
    with LoginValidationMixin {
  final _formKey = GlobalKey<FormState>();
  late String nickname;
  final String userid;
  _UserInfoEditFormState(this.userid);
 var buttonColor = Colors.blue[400];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: "nickname" ,
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.black45, width: 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
            ),
            validator: validateFirstName,
            onSaved: (val) {
              nickname = val!;
            },
          ),
        const SizedBox(
          height: 10,
        ),
          
          SizedBox(
            height: 54,
            width: 50,
            child: RaisedButton(
              padding: EdgeInsets.all(5.0),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  CloudFirestore().updateUserName(nickname,userid);
                  setState(() {
                    buttonColor = Colors.green[400];
                  });
                  }
                },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0))),
              color: buttonColor,
              textColor: Colors.white,
              child: const Text(
                'Update',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
