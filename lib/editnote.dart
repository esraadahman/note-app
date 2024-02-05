import 'package:amira/home.dart';
import 'package:flutter/material.dart';
import 'package:amira/dbhelper.dart';
import 'package:amira/main.dart';
import 'package:sqflite/sqflite.dart';

class EditNote extends StatefulWidget {
  final int id;
  final String title;
  final String description;

  EditNote({Key? key, required this.id, required this.title, required this.description}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late SqlHelper sqldb;
  late TextEditingController text_filed;
  late TextEditingController text_area;

  @override
  void initState() {
    super.initState();
    sqldb = SqlHelper();
    text_filed = TextEditingController(text: widget.title);
    text_area = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.orange[700],
          title: const Text(
            "Edit Notes",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                  margin: EdgeInsets.fromLTRB(5, 25, 5, 0),
                  child: TextFormField(
                    controller: text_filed,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      labelText: "title",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
                  child: TextFormField(
                    controller: text_area,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    maxLines: 20,
                    minLines: 10,
                  ),
                ),
                Container(
                  height: 70,
                  width: 180,
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                  margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                  child: ElevatedButton(
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      int response = await sqldb.updateData('''UPDATE notes SET title = '${text_filed.text}',
                          description = '${text_area.text}' WHERE id = ${widget.id}''');
                      if (response > 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
                      }
                      print(response);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    text_filed.dispose();
    text_area.dispose();
    super.dispose();
  }
}
