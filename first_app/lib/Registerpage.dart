//import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget{
  final VoidCallback showLoginPage;
  const Registerpage({Key? key,
    required this.showLoginPage}) : super(key: key);

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _usernameController=TextEditingController();
  final _emailController= TextEditingController();
  final _passwordController=TextEditingController();
  final _conformpasswordController=TextEditingController();
  bool _isPasswordVisible = false;
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _conformpasswordController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  Future<void> signUp() async {
    if (!passwordConfirm()) {
      showSnackBar("Passwords do not match!", Colors.red);
      return;
    }

    try {
      // Create user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Automatically store UID in Firestore
      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,  // Storing UID automatically
        "username": _usernameController.text.trim(),
        "email": _emailController.text.trim(),
      });

      showSnackBar("Registration Successful!", Colors.green);
    } catch (e) {
      showSnackBar("Error: ${e.toString()}", Colors.red);
    }
  }

  bool passwordConfirm() {
    return _passwordController.text.trim() == _conformpasswordController.text.trim();
  }
  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              color: Colors.white12,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.text,//for taking number keyboard
                    controller: _usernameController,
                    decoration:InputDecoration(
                        hintText: "User Name",
                        focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2 ,
                              color: Colors.blueAccent
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.black45
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.lightGreenAccent,
                            )
                        ),

                        //prefixText: "enter gmail",
                        prefixIcon: Icon(Icons.adb,color: Colors.blue,)
                    ) ,
                  ),Container(height:10 ),
                  TextField(
                    keyboardType: TextInputType.text,//for taking number keyboard
                    controller: _emailController,
                    decoration:InputDecoration(
                        hintText: "Enter Email",
                        focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2 ,
                              color: Colors.blueAccent
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.black45
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.lightGreenAccent,
                            )
                        ),

                        //prefixText: "enter gmail",
                        prefixIcon: Icon(Icons.email,color: Colors.blue,)
                    ) ,
                  ),
                  Container(height:10 ),
                  //Take Password
                  TextField(//use for taking text input from user
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    //for hiding password
                    obscuringCharacter: '*',
                    //keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        hintText: "Password",
                        focusedBorder: OutlineInputBorder(//jevha aapan button var click karto tevha button  cha color change hoto
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.blueAccent
                            )
                        ),
                        enabledBorder: OutlineInputBorder(//color disto jevha aapan button var click nahi karat tevha
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.black45
                            )
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: Colors.lightBlue,
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: (){
                            setState(() {

                              _isPasswordVisible =
                              !_isPasswordVisible; // Toggle state
                            });

                          },

                        ),
                      prefixIcon: Icon(Icons.lock,color: Colors.blue,)
                    ),
                  ),
                  Container(height: 10),

                  TextField(//use for taking text input from user
                    controller: _conformpasswordController,
                    //for hiding password
                    obscuringCharacter: '*',
                    //keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        hintText: "Conform Password",
                        focusedBorder: OutlineInputBorder(//jevha aapan button var click karto tevha button  cha color change hoto
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.blueAccent
                            )
                        ),
                        enabledBorder: OutlineInputBorder(//color disto jevha aapan button var click nahi karat tevha
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.black45
                            )
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        prefixIcon: Icon(Icons.lock,color: Colors.blue,)
                    ),
                  ),
                  Container(height: 10),

                  /*

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.red),
                        child: Center(
                            child: Text("Sign in")),
                      ),
                    ),
                  ),

                   */


                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.cyan),
                        elevation: WidgetStatePropertyAll(10),
                        shadowColor: WidgetStatePropertyAll(Colors.blue),
                        overlayColor: WidgetStatePropertyAll(Colors.lightBlue)
                    ),
                    child: Text("Create Account",style: TextStyle(
                      fontSize: 30,
                      color: Colors.purpleAccent,
                    ),
                    ),
                    onPressed: signUp,
                  ),
                  Container(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",style: TextStyle(color: Colors.black87),),
                      GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Text(" Login",style: TextStyle(color: Colors.blue),)
                      ),
                    ],
                  )


                ],
              )
          )
      ),
    );

  }
}