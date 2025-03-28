import 'dart:async';



import 'package:first_app/mainpage.dart';
import 'package:flutter/material.dart';

import 'package:first_app/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //initial state
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => mainpage(),//kontya page var jayche ahe tya saathi use hoto (Splashscreen varun Intropage,likewise)
          ));
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.2,
              colors: [
                Color(0xFF8DC63F),
                Color(0xFFB5E08C),
                Color(0xFFF1F8E9),
              ],
              stops: [0.1, 0.5, 1.0],
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), // Adjust radius manually
                    image: DecorationImage(
                      image: AssetImage('assets/images/applogo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Text(
                'MediVoice UI',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
/*
child: Text(
'MediVoice UI',
style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
),

 */