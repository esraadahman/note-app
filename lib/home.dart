import 'package:amira/editnote.dart';
import 'package:flutter/material.dart';
import 'package:amira/addnotes.dart';
import 'package:amira/dbhelper.dart';

void main() => runApp(home());

class home extends StatelessWidget {
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
  SqlHelper sqldb = SqlHelper();
  List notes = [];
  bool isChecked = false ;

  Future<void> readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM notes");
    notes.addAll(response);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
    // Call the async method in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          "Note App",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[700],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addnote()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
          child: ListView.builder(
              itemCount: notes.length,
              shrinkWrap: true,
              itemBuilder: (context , i){
                return Card(
                    child:
                    Container(
                        height: 90,
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        padding:  const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: Colors.orange[200],
                          // borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:
                        Row( children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${notes[i]['title']}",style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                              ) ,
                              Text(
                                "${notes[i]['description'].substring(0, 2)}....",style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              )
                            ],
                          ),


                          // ListTile(
                          //   title: Text("${notes[i]['title']}",style: TextStyle(
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 20),
                          //   ) ,
                          //   subtitle: Text(
                          //     "${notes[i]['description'].substring(0, 5)}....",style: TextStyle(
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.w500,
                          //       fontSize: 10),
                          //   ),),

                          Padding(padding: EdgeInsets.fromLTRB(150, 2, 0, 0),
                            child:
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.orange[700],
                                size: 15,
                              ),
                              onPressed: () async{
                                int response = await sqldb.deleteData("DELETE FROM notes WHERE id = ${notes[i]['id']}");
                                if(response > 0){ Navigator.push(context, MaterialPageRoute(builder: (context)=>home())); }

                              },
                            ),),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child:
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.orange[700],
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(id: notes[i]['id'], title:  notes[i]['title'], description:  notes[i]['description']))); }
                              )),
                          Checkbox(
                            value: isChecked, // Current state of the checkbox
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue ?? false; // Update the state of the checkbox
                              });
                            },
                            activeColor: Colors.orange[700], // Color when the checkbox is selected
                            checkColor: Colors.white, // Color of the check symbol
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                            visualDensity: VisualDensity.compact,

                // Adjust checkbox density
                          ),
                        ] )
                    ),



                );



                //*************************************************************
              })
      ),
    );
  }
}
