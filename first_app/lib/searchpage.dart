/*
Use Hero for main screen in app(gridview),
 */
import 'package:flutter/material.dart';
import 'package:first_app/homepage.dart';

class searchpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /*body:  Container(
          child: Center(
            child: InkWell(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Hero(
                tag:  'background',
                  child: Image.asset('assets/images/logo.jpg',width: 500,height: 200,)),
            ),
          ))


       */

// pahila container ghyayacha nantar tyall Hero widget ne wrap karayacha ani tyall parat InkWell ne crap karayacha
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => homepage(),));
                    },
                    child: Hero(
                      tag: 'background',
                      child: Container(
                        width: 500,
                        height: 500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => homepage(),));
                    },
                    child: Hero(
                      tag: "background",
                      child: Container(
                        width: 500,
                        height: 500,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 500,
                    height: 500,
                    color: Colors.amber,
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 500,
                    height: 500,
                    color: Colors.lightGreenAccent,
                  ),
                ),
              ],
            ),
          ),/*
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 140,
                width: 412,
                color: Colors.lightGreenAccent,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        Column(
                          children: [
                            Icon(
                              //pahile icon la ghyayache ani tyala column madhe takayache, nantar
                              //dusarya children madhe text ghyayacha mag to text icon chya khali yeil
                              //ase 4 column banavache 4 icon saathi ani tyala row madhe taakayche,
                              //mag te row madhe yetil ,nantar row bottom la nenyasathi, row la column
                              //madhe takayche ani ,background color sathi tyala container madhe takayche
                              Icons.home,
                              size: 100,
                              color: Colors.blue,
                            ),
                            Text("Home",
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.medication,color: Colors.blue,size: 100,),
                            Text("Medication",
                              style: TextStyle(
                                  color: Colors.black),)
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.update,color: Colors.blue,size: 100,),
                            Text("Update",style: TextStyle(color: Colors.black),)
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.manage_history,color: Colors.blue,size: 100,),
                            Text("Manage",style: TextStyle(color: Colors.black),)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )*/
        ],
      ),


      /*
    body: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      },
      child: Hero(
        tag: "background",
          child: Image.asset('assets/images/logo.jpg',width: 500,height: 200,)),
    ),

     */
    );

  }
}