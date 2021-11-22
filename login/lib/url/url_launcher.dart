import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher{

  Future urlOpen(String link) async{
    if(await canLaunch(link)){
      await launch(link);
    }
    else{
      debugPrint("Link açılmıyor");
    }
  }
}