import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/oop_student.dart';
import 'package:login/validation/validatior.dart';
import 'package:login/widgets/appbar_widget.dart';


class StudentEdit extends StatefulWidget {
  var selectedStudentTC;
  var selectedStudentFirstName;
  var selectedStudentLastName;
  var selectedStudentGrade;
  var selectedStudentAvatarURL;
  StudentEdit(this.selectedStudentTC,this.selectedStudentFirstName,this.selectedStudentLastName,this.selectedStudentGrade,this.selectedStudentAvatarURL, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedStudentTC,selectedStudentFirstName,selectedStudentLastName,selectedStudentGrade,selectedStudentAvatarURL);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  var selectedStudentTC;
  var selectedStudentFirstName;
  var selectedStudentLastName;
  var selectedStudentGrade;
  var selectedStudentAvatarURL;

  var keyForm = GlobalKey<FormState>();

  _StudentAddState(this.selectedStudentTC,this.selectedStudentFirstName,this.selectedStudentLastName,this.selectedStudentGrade,this.selectedStudentAvatarURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBarWidget("Student Edit"),
        body: ListView(
      children:  [
          Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key: keyForm,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15.0,
                  ),
                  selectedStudentAvatarURL != ""
                      ? Image(
                    image: NetworkImage(
                        selectedStudentAvatarURL),width: 150,height: 150,
                  )
                      : Image.asset(
                    "assets/images/notfound.png",
                    height: 150,
                    width: 150,
                  ),


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
                ],
              ),
            ),
          ),
        ],),);
  }

  Widget buildFirstNameField() {
    return TextFormField(
        initialValue: selectedStudentFirstName,
        decoration:
        const InputDecoration(labelText: "Öğrenci Adı", hintText: "Öğrenci Adı",prefixIcon: Icon(Icons.account_circle_sharp),),
        validator: validateFirstName,
        onSaved: (String? value) {
          selectedStudentFirstName = value!;
        });
  }

  Widget buildLastNameField() {
    return TextFormField(
        initialValue: selectedStudentLastName,
        decoration:
        const InputDecoration(labelText: "Öğrenci SoyAdı", hintText: "Öğrenci SoyAdı",prefixIcon: Icon(Icons.account_circle_sharp),),
        validator: validateLastName,
        onSaved: (String? value) {
          selectedStudentLastName = value!;
        });
  }

  Widget buildGradeField() {
    return TextFormField(
        initialValue: selectedStudentGrade.toString(),
        decoration: const InputDecoration(labelText: "Öğrenci Notu", hintText: "Öğrenci Notu", prefixIcon: Icon(Icons.grade),),
        validator: validateGrade,
        onSaved: (String? value) {
          selectedStudentGrade = value!;
        });
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: const Text("KAYDET"),
      onPressed: () {
        setState(() {
          if (keyForm.currentState!.validate()) {
            keyForm.currentState!.save();
            Student().updateUser(selectedStudentTC, selectedStudentFirstName, selectedStudentLastName, selectedStudentGrade, selectedStudentAvatarURL);
            Navigator.pop(context);
          }
        });
      },
    );
  }
}
