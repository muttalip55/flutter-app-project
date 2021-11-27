import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key, required this.userid}) : super(key: key);
  final String userid;

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState(userid);
}

class _UserInfoWidgetState extends State<UserInfoWidget>
    with WidgetsBindingObserver {

  final firestoreRef = FirebaseFirestore.instance;
  final String userid;
  _UserInfoWidgetState(this.userid);

  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<QuerySnapshot>(
          future: firestoreRef.collection("userinfo").get(),
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
                                  FadeInImage(
                                    alignment: Alignment.center,
                                    image: NetworkImage(data["avatarURL"]),
                                    placeholder: AssetImage(
                                      "assets/images/notfound.png",
                                    ),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/notfound.png",
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.fitWidth,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(top: 20.0)),
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
                              Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 15.0)),
                                  Center(
                                    child: OutlinedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            UserInfoWidget(userid: userid);
                                          });
                                        },
                                        icon: Icon(Icons.replay),
                                        label: Text("Yenile")),
                                  )
                                ],
                              )
                            ],
                          ),
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
    );
  }
}
