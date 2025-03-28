import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class presshome extends StatefulWidget {
  @override
  State<presshome> createState() => _presshomeState();
}

class _presshomeState extends State<presshome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName = "Loading...";
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
    return Scaffold(
      /* body: GridView.count(
        crossAxisCount: 2, // 2 columns
        childAspectRatio: 1, // Square cells
        mainAxisSpacing: 8.0, // Spacing between rows
        crossAxisSpacing: 8.0,

        children: [
          GestureDetector(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red, ),

              ),

            ),

            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return homepage();
              },));
            },

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepOrange, ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue, ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.purple, ),
            ),
          ),
        ],
      ),*/
      /* body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => searchpage(),));
                    },
                    child: Container(
                      height: 303,
                      width: 176,
                      child: Center(child: Text("Prescription Reader",style: TextStyle(fontSize: 30))),

                      decoration: BoxDecoration(color: Colors.lightGreen,borderRadius: BorderRadius.circular(20))


                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 303,
                      width: 176,
                      child: Center(child: Text("Your Schedules ",style: TextStyle(fontSize: 30))),

                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.lightGreen),
                    ),
                  ),
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 303,
                  width: 176,
                  color: Colors.deepOrange ,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 303,
                    width: 176,
                    color: Colors.purpleAccent,
                  ),
                )
              ],
            ),
          ),

        ],
      ),*/
      body: Container(
        color: Colors.white24,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Center(
                    child: Container(
                        child: Text(
                  "   Hii   $userName",
                  style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
                ))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Center(
                    child: GestureDetector(
                      child: Container(
                        height: 250,
                        width: 350,
                        child: Center(
                            child: Text("Add Schedule",
                                style: TextStyle(fontSize: 30))),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Container(
                    height: 303,
                    width: 176,
                    child: Image(
                      image: AssetImage('assets/images/img.png'),
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 303,
                      width: 176,
                      child: Center(
                          child: Text(
                        "Prescription Reader",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black12),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
