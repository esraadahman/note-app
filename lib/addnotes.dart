import 'package:amira/dbhelper.dart';
import 'package:amira/home.dart';
import 'package:amira/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
void main() => runApp(addnote());

class addnote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHome()
    );
  }
}

class MyHome extends StatelessWidget {
  SqlHelper sqldb = SqlHelper();
  TextEditingController text_filed = TextEditingController();
  TextEditingController text_area = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.orange[700],
        // centerTitle: true,
        title: const   Text("Add Notes",   style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 30),),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
              },
            )
          ],
    ),

   body:   SingleChildScrollView(
    child:
     Form(
     child: Column(
       children: <Widget>[
     Container(
       padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
        margin: EdgeInsets.fromLTRB(5, 25, 5, 0),
       child:
       TextFormField(
           controller: text_filed,
           decoration: const InputDecoration(
             icon: const Icon(Icons.title),
             labelText: 'Title',
             border: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.black), // Set border color to black
             ),
           ),
         ),),
          Container(
            //padding: EdgeInsets.fromLTRB(, 0, 0, 0),
             margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child:
            TextFormField(
           controller: text_area,
           decoration: const InputDecoration(
            labelText: 'description',
             border: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.black), // Set border color to black
             ),
          ),
           maxLines: 20,
           minLines: 10,
         ),),

         Container(
             height: 70,
             width: 150,
             padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
              margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
             child:ElevatedButton(
               child: const Text('ADD ' ,style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.bold,
                   // fontWeight: FontWeight.w500,
                   fontSize: 20),),
               onPressed: () async {
                 int response = await sqldb.insertData('''INSERT INTO 'notes' (title, description) VALUES
                  ( "${text_filed.text}", "${text_area.text}");''');
                if(response > 0){ Navigator.push(context, MaterialPageRoute(builder: (context)=>home())); }

               },
               style: ElevatedButton.styleFrom(
                 primary: Colors.orange[700],
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                 ),
               ),)),
       ],
     ),)
     

    ))


    );}}