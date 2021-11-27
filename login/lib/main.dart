import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/screen/home.dart';
import 'package:login/screen/oop_student/student_list.dart';
import 'screen/registry/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(0.0),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          labelStyle: TextStyle(color:Colors.white),
        ),
      ),
      title: 'Flutter App',
      home:  Login(),
    );
  }
}