import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/url/url_launcher.dart';
import 'package:share/share.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  late String appBarText;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  AppBarWidget(this.appBarText);

  Widget build(BuildContext context) {
    return buildAppBarWidget(context);
  }

  @override
  Widget buildAppBarWidget(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: AppBar(
        title: Text(
          appBarText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade500,
        actions: [
          IconButton(
            onPressed: () {
              UrlLauncher().urlOpen(Platform.isAndroid
                  ? "market://details?idcom.example.login "
                  : "itms-apps:itnues.apple.com/us/app/id");
            },
            icon: const Icon(Icons.star),
            tooltip: "Puan ver",
          ),
          IconButton(
            onPressed: () {
              Share.share("""Mobil uygulamamız. 
              Adroid: https//play.google.com/store/apps/details?idcom.example.login 
              IOS: https://itnues.apple.com/us/app/id""");
            },
            icon: const Icon(Icons.share),
            tooltip: "Paylaş",
          ),
        ],
      ),
    );
  }
}
