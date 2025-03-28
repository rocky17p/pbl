/*The InkWell widget is used to create a material "ripple effect"
when the user taps on a widget, often used for buttons or touchable areas.
It's typically used to give users feedback that their interaction has been recognized.
You can use the InkWell widget around any widget that you want to make interactive,
 like a Container, Image, or even Text
 use for main page of your app
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/premdesign.dart';
import 'package:flutter/material.dart';
import 'package:first_app/homepage.dart';
import 'package:first_app/searchpage.dart';
import 'package:first_app/presshome.dart';

//material is used for android application
//import 'package:flutter/cupertiono.dart';
//cupertino -> is used for iphone's application
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userName = "Loading...";
  int selectindex = 0;
  PageController pageController = PageController();
  void onTapped(int index) {
    setState(() {
      selectindex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection("users").doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            userName = userDoc["username"];
          });
        }
      }
    } catch (e) {
      print("Error fetching user name: $e");
      setState(() {
        userName = "Error loading name";
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediVoice',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          //leading: Icon(Icons.menu,size: 35,),
          // title: Text('Guest',style: TextStyle(color: Colors.black87),),
          //actions: [
          // Icon(Icons.notifications,size: 35,)
          //  ],
        ),
        drawer: Drawer(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(children: [
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(
                  "WelCome Back $userName",
                  style: TextStyle(color: Colors.purpleAccent),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Setting"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help),
                title: Text("Help & Support"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log out"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ]),
          ),
        ),
        body: PageView(
          controller: pageController,
          children: [
            myhomepage(title: 'medivoice',),
            presshome(),
            searchpage(),
            homepage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.blue), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.blue), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.call, color: Colors.blue), label: 'Call'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message, color: Colors.blue), label: 'message')
          ],
          currentIndex: selectindex,
          selectedItemColor: Colors.purpleAccent,
          //unselectedItemColor: Colors.red,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: onTapped,
        ),
      ),
    );
  }
}
