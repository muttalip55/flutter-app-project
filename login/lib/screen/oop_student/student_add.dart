import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/oop_student.dart';
import 'package:login/validation/validatior.dart';
import 'package:login/widgets/appbar_widget.dart';

class StudentAdd extends StatefulWidget {
  late List<Student>  students;
  StudentAdd(List<Student> students) {
    this.students = students;
  }

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  late List<Student> students;
  var student = Student.withoutInfo();
  var keyForm = GlobalKey<FormState>();

  _StudentAddState(List<Student> students) {
    this.students = students;
  }

  @override
  Widget build(BuildContext context) {
    print(students.length);
    return Scaffold(
        appBar: AppBarWidget("Student Add"),
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
        decoration:
        InputDecoration(labelText: "Öğrenci Adı", hintText: "Muttalip"),
        validator: validateFirstName,
        onSaved: (String? value) {
          student.firstName = value!;
        });
  }

  Widget buildLastNameField() {
    return TextFormField(
        decoration:
        InputDecoration(labelText: "Öğrenci SoyAdı", hintText: "Olgun"),
        validator: validateLastName,
        onSaved: (String? value) {
          student.lastName = value!;
        });
  }

  Widget buildGradeField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Öğrenci Notu", hintText: "65"),
        validator: validateGrade,
        onSaved: (String? value) {
          student.grade = int.parse(value!);
        });
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("KAYDET"),
      onPressed: () {
        setState(() {
          if (keyForm.currentState!.validate()) {
            keyForm.currentState!.save();
            students.add(student);
            Navigator.pop(context);
          }
        });
      },
    );
  }
}
