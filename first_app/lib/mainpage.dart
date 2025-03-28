import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Authpage.dart';
import 'package:first_app/LoginPage.dart';
import 'package:first_app/homescreen.dart';
import 'package:first_app/homepage.dart';
import 'package:first_app/homepage.dart';
import 'package:flutter/material.dart';

class mainpage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        if(snapshot.hasData){
          return MyApp();
        }else{
          return Authpage();
        }
      },),
    );
  }

}