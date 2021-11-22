import 'package:flutter/material.dart';
import 'package:login/auth/authentication.dart';
import 'package:login/screen/registry/login.dart';
import 'package:login/screen/side_menu.dart';
import 'package:login/screen/user_edit.dart';
import 'package:login/widgets/appbar_widget.dart';
import 'package:login/widgets/user_info_widget.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.userid}) : super(key: key);
  late String userid;
  @override
  _HomeState createState() => _HomeState(userid);


}
class _HomeState extends State<Home> {

  _HomeState(this.userid);
  late final String userid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget("Welcome"),
      body: UserInfoWidget(userid: userid),
      drawer: SideMenu(),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserEditWidget(userid: userid)));
                },
                heroTag: null,
                child: Icon(Icons.edit),
                tooltip: 'Edit',

              ),
              SizedBox(
                height: 50,
              ),

              FloatingActionButton(
                onPressed: () {
                  AuthenticationHelper()
                      .signOut()
                      .then((_) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  ));
                },
                heroTag: null,
                child: Icon(Icons.logout),
                tooltip: 'Logout',
              ),
            ]
        )
    );
  }
}