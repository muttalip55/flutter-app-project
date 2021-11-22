import 'package:flutter/material.dart';
import 'package:login/screen/api_screen.dart';
import 'package:login/screen/info.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var line = const Divider(
      height: 1.0,
      color: Colors.black,
    );

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.blueGrey.shade50,
              child: Image.asset("assets/images/ust2.png"),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.all_inclusive),
                    title: const Text("JSON"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ApiScreen()));
                    },
                  ),
                  line,
                  ListTile(
                    leading: const Icon(Icons.event),
                    title: const Text("Sqflite"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  line,
                  ExpansionTile(
                    title: Text("Başlık3"),
                    leading: Icon(Icons.account_box),
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          leading: const Icon(Icons.event),
                          title: const Text("AltBaşlık1"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      line,
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          leading: const Icon(Icons.rate_review),
                          title: const Text("AltBaşlık2"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  line,
                  ListTile(
                    leading: const Icon(Icons.event),
                    title: const Text("Info"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Info()));
                    },
                  ),
                  line,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
