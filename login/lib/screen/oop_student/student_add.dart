import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/models/oop_student.dart';
import 'package:login/validation/validatior.dart';
import 'package:login/widgets/appbar_widget.dart';

class StudentAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState();
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  late String tc;
  late String firstName;
  late String lastName;
  late int grade;
  late String avatarURL;
  XFile? selectedFile;
  final ImagePicker _picker = ImagePicker();
  String _selectedFileName = "";
  String uploadPath = "";
  bool LoadImg = false;

  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBarWidget("Student Add"),
      body: ListView(
        children: [
          LoadImg
              ? CircularProgressIndicator()
              : uploadPath != ""
              ? Image(
            image: NetworkImage(
                uploadPath),width: 150,height: 150,
          )
              : Image.asset(
            "assets/images/notfound.png",
            height: 150,
            width: 150,
          ),

          _selectedFileName == ""
              ? Container(child: Text(_selectedFileName))
              : Text("File Name :" + _selectedFileName),


          Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: keyForm,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTCField(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildFirstNameField(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildLastNameField(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildGradeField(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildSubmitButton(),
                  const SizedBox(
                    height: 15.0,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTCField() {
    return TextFormField(
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          labelText: "Öğrenci TC",
          hintText: "Öğrenci TC",
          prefixIcon: Icon(Icons.lock),
          fillColor: Colors.deepPurple,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        validator: validateFirstName,
        onSaved: (String? value) {
          tc = value!;
        });
  }

  Widget buildFirstNameField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: "Öğrenci Adı",
          hintText: "Öğrenci Adı",
          prefixIcon: Icon(Icons.account_circle_sharp),
          fillColor: Colors.deepPurple,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        validator: validateFirstName,
        onSaved: (String? value) {
          firstName = value!;
        });
  }

  Widget buildLastNameField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: "Öğrenci SoyAdı",
          hintText: "Öğrenci SoyAdı",
          prefixIcon: Icon(Icons.account_circle_sharp),
          fillColor: Colors.deepPurple,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        validator: validateLastName,
        onSaved: (String? value) {
          lastName = value!;
        });
  }

  Widget buildGradeField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: "Öğrenci Notu",
          hintText: "Öğrenci Notu",
          prefixIcon: Icon(Icons.grade),
          fillColor: Colors.deepPurple,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        validator: validateGrade,
        onSaved: (String? value) {
          grade = int.parse(value!);
        });
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("KAYDET"),
      onPressed: () {
        setState(() {
          keyForm.currentState!.save();
          if (keyForm.currentState!.validate() && uploadPath != "") {
            setState(() {

            });
          Student().createStudentData(
                tc, firstName, lastName, grade.toString(), uploadPath);
            Navigator.pop(context);
          }
        });
      },
    );
  }
  Future<void> uploadFile(XFile file) async {
    String uploadFileName = tc;
    Reference reference =
    FirebaseStorage.instance.ref().child("students").child(tc);
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
