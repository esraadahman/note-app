import 'package:amira/editnote.dart';
import 'package:amira/home.dart';
import 'package:flutter/material.dart';
import 'package:amira/addnotes.dart';
import 'package:amira/dbhelper.dart';

void main() => runApp(first_screen());

class first_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: NetworkImage("https://images.pexels.com/photos/7965168/pexels-photo-7965168.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    fit: BoxFit.cover,
    ),
    ),
    child:Scaffold(
    backgroundColor: Colors.transparent,
    // appBar: AppBar(
    //   // centerTitle: true,
    //   title: const   Text("Weather App"),

    //  ),
    body: Column(
    children: [
    Padding(padding:EdgeInsets.fromLTRB(5, 300, 0, 5), //apply padding to all four sides
    child:
    Text(
    'Save your  memories',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    // fontWeight: FontWeight.w500,
    fontSize: 25),
    ),),
    Padding(padding:EdgeInsets.fromLTRB(40, 2, 40, 40), //apply padding to all four sides
    child:
    Text(
    "We help you remember and memorize things, so let's get started",
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 17),
    ),),
    Row(
    children:[
    Container(
    height: 50,
    padding: const EdgeInsets.fromLTRB(190, 20, 0, 0),
    child:ElevatedButton(
    child: const Text('HOME',style: TextStyle(
      color: Colors.black
    ),),
    onPressed: () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
    },
    style: ElevatedButton.styleFrom(
    primary: Colors.orange[700],
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
    ),
    ),
    )
    ),



    ]),


    ]))));}}