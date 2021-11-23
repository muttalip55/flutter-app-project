import 'package:flutter/material.dart';
import 'package:login/models/oop_student.dart';
import 'package:login/screen/oop_student/student_add.dart';
import 'package:login/screen/oop_student/student_edit.dart';
import 'package:login/widgets/appbar_widget.dart';

class StudentList extends StatefulWidget {
  StudentList({Key? key}) : super(key: key);
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late Student selectedStudent = Student.withId(0, "", "", 0, "");
  List<Student> students = [
    Student.withId(1, "Muttalip", "Olgun", 25,
        "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png"),
    Student.withId(2, "Nurseli", "Ozgur", 65,
        "https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_960_720.png"),
    Student.withId(3, "Ahmet", "Olgun", 45,
        "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget("Student List"), body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(students[index].avatarURL.toString()),
                    ),
                    title: Text(students[index].getFirstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sinavdan Aldigi Not : " +
                        students[index].grade.toString() +
                        "{" +
                        students[index].getStatus +
                        "}"),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                    },
                    onLongPress: () {
                      Sonuc(students[index].getStatus, context);
                    },
                  );

                  //Text(students[index].firstName);
                })),
        Text("Seçilen öğrenci : " + selectedStudent.firstName),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.deepPurple,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Yeni Ogrenci"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAdd(students)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.black12,
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("GUNCELLE"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentEdit(selectedStudent)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.amber,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("SIL"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    Sonuc("Silindi : " + selectedStudent.firstName, context);
                    students.remove(selectedStudent);
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.check);
    } else if (grade >= 40) {
      return Icon(Icons.circle);
    } else {
      return Icon(Icons.next_plan_outlined);
    }
  }

  String SinaviHesapla() {
    int puan = 55;
    String mesaj = "";
    if (puan >= 50) {
      mesaj = "Gecti";
    } else if (puan >= 40) {
      mesaj = "Butunlemeye Kaldi";
    } else {
      mesaj = "Kaldi";
    }
    return mesaj;
  }

  void Sonuc(String mesaj, BuildContext context) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
