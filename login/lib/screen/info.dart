import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login/url/url_launcher.dart';
import 'package:login/widgets/appbar_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget("INFO"),
      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 100,
              child: const Center(
                child: Icon(
                  FontAwesomeIcons.home,
                  size: 60,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Text(
                "Kemalpaşa Esentepe Kampüsü, Üniversite Cd., 54050 Serdivan/Sakarya",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ///////////////////////////////
            Container(
              height: 100,
              child: Center(
                child: InkWell(
                  onTap: () {
                    UrlLauncher().urlOpen("tel:+905531542348");
                  },
                  child: const Icon(
                    FontAwesomeIcons.phone,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Text(
                "0 553 154 23 48",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ////////////////////////

            Container(
              height: 100,
              child: Center(
                child: InkWell(
                  onTap: () {
                    UrlLauncher().urlOpen("mailto:muttalip326@gmail.com");
                  },
                  child: const Icon(
                    FontAwesomeIcons.envelope,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Text(
                "muttalip326@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
