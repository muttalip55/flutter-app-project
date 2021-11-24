import 'package:cloud_firestore/cloud_firestore.dart';
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
  late String selectedStudentTC = "";
  late String selectedStudentFirstName = "";
  late String selectedStudentLastName = "";
  late String selectedStudentGrade = "";
  late String selectedStudentAvatarURL = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget("Student List"), body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("students").get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot> arrData = snapshot.data!.docs;
                return Column(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: arrData.map((data) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: FadeInImage(
                                  alignment: Alignment.center,
                                  image: NetworkImage(data["avatarURL"]),
                                  placeholder: AssetImage(
                                    "assets/images/notfound.png",
                                  ),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/notfound.png",
                                      fit: BoxFit.fitWidth,
                                    );
                                  },
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              title: Text(
                                  data["FirstName"] + " " + data["LastName"]),
                              subtitle: Text("Sinavdan Aldigi Not : " +
                                  data["grade"].toString()),
                              trailing:
                                  buildStatusIcon(int.parse(data["grade"])),
                              onTap: () {
                                setState(() {
                                  selectedStudentFirstName = data["FirstName"];
                                  selectedStudentLastName = data["LastName"];
                                  selectedStudentTC = data["tc"];
                                  selectedStudentGrade = data["grade"];
                                  selectedStudentAvatarURL = data["avatarURL"];
                                });
                              },
                              onLongPress: () {
                                Sonuc(getStatus(int.parse(data["grade"])),
                                    context);
                              },

                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    Text("Seçilen öğrenci No : " + selectedStudentTC,style: const TextStyle(color: Colors.redAccent),),
                    Text("Seçilen öğrenci : " + selectedStudentFirstName + " " + selectedStudentLastName,style: TextStyle(color: Colors.redAccent),),

                  ],
                );
              } else {
                return const Center(
                  child: Text("No data Found"),
                );
              }
            }),
        /////////
        Expanded(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child:  Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: RaisedButton(
                            color: Colors.deepPurple,
                            child: Row(
                              children: const [
                                Icon(Icons.add),
                                SizedBox(
                                  width: 5.0,
                                  height: 5.0,
                                ),
                                Text("Yeni Ogrenci"),
                              ],
                            ),
                            onPressed: () {
                              setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentAdd()));
                            },
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: RaisedButton(
                            color: Colors.black12,
                            child: Row(
                              children: const [
                                Icon(Icons.update),
                                SizedBox(
                                  width: 5.0,
                                  height: 5.0,
                                ),
                                Text("GUNCELLE"),
                              ],
                            ),
                            onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => StudentEdit(selectedStudentTC,selectedStudentFirstName,selectedStudentLastName,selectedStudentGrade,selectedStudentAvatarURL))); ///DUZENLE
                            },
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: RaisedButton(
                            color: Colors.amber,
                            child: Row(
                              children: const [
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 5.0,
                                  height: 5.0,
                                ),
                                Text("SIL"),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                Sonuc("Silindi : " + selectedStudentFirstName + " " + selectedStudentLastName, context);
                                Student().deleteUser(selectedStudentTC);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              )),
        ),
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

  void Sonuc(String mesaj, BuildContext context) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  String getStatus(int grade) {
    String message = "";
    if (grade >= 50) {
      message = "Gecti";
    } else if (grade >= 40) {
      message = "Butunlemeye Kaldi";
    } else {
      message = "Kaldi";
    }
    return message;
  }
}
