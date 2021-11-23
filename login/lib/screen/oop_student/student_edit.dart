import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/oop_student.dart';
import 'package:login/validation/validatior.dart';
import 'package:login/widgets/appbar_widget.dart';


class StudentEdit extends StatefulWidget {
  var selectedStudent;
  StudentEdit(Student selectedStudent) {
    this.selectedStudent = selectedStudent;
  }

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedStudent);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  var selectedStudent;
  var keyForm = GlobalKey<FormState>();

  _StudentAddState(Student students) {
    selectedStudent = students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget("Student Edit"),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: keyForm,
            child: Column(
              children: <Widget>[
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeField(),
                buildSubmitButton()
              ],
            ),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
        initialValue: selectedStudent.firstName,
        decoration:
        InputDecoration(labelText: "Öğrenci Adı", hintText: "Muttalip"),
        validator: validateFirstName,
        onSaved: (String? value) {
          selectedStudent.firstName = value!;
        });
  }

  Widget buildLastNameField() {
    return TextFormField(
        initialValue: selectedStudent.lastName,
        decoration:
        InputDecoration(labelText: "Öğrenci SoyAdı", hintText: "Olgun"),
        validator: validateLastName,
        onSaved: (String? value) {
          selectedStudent.lastName = value!;
        });
  }

  Widget buildGradeField() {
    return TextFormField(
        initialValue: selectedStudent.grade.toString(),
        decoration: InputDecoration(labelText: "Öğrenci Notu", hintText: "65"),
        validator: validateGrade,
        onSaved: (String? value) {
          selectedStudent.grade = int.parse(value!);
        });
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("KAYDET"),
      onPressed: () {
        setState(() {
          if (keyForm.currentState!.validate()) {
            keyForm.currentState!.save();
            Navigator.pop(context);
          }
        });
      },
    );
  }
}
