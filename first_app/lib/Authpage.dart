import 'package:first_app/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Registerpage.dart';

class Authpage extends StatefulWidget{
  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  // initially,shoe login page
  bool showLoginPage= true;
  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });

  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(showRegisterPage: toggleScreens );
    }else{
      return Registerpage(showLoginPage: toggleScreens );
    }
  }
}
/*
How Does It Work?
App starts with showLoginPage = true → LoginPage appears.
User taps "Sign up" → toggleScreens() is called.
showLoginPage becomes false.
RegisterPage is displayed.
User taps "Go to Login" → toggleScreens() is called again.
showLoginPage becomes true.
LoginPage appears again.
 */