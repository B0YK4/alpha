import 'dart:convert';
import 'dart:io';

import 'package:alpha/models/patient.dart';
import 'package:alpha/services/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:alpha/main.dart';

class AddPatient extends StatefulWidget {
  final String id;
  AddPatient({this.id});
  @override
  _AddPatientState createState() => _AddPatientState();
}

List<File> operations;
List<File> examinations;
List<File> statements;
List<String> newstatements;
List<String> newexaminations;
List<String> newoperations;

void addPatient(Patient patient) async {
  final patientsBox = Hive.box('testbox');
  print('===============patient==json=================');

  print(patient.toJson());
  patientsBox.add(json.encode(patient.toJson()));
}

Future<List<String>> saveSheets(String sheetname, List<File> sheets) async {
  if (sheets == null) return null;
  List<String> newsheets = [];
  for (int ctr = 0; ctr < sheets.length; ctr++) {
    final File newImage = await sheets[ctr].copy('$sheetname$ctr.jpg');
    newsheets.add(newImage.path);
  }
  return newsheets;
}

class _AddPatientState extends State<AddPatient> {
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    statements = null;
    operations = null;
    examinations = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                            padding: EdgeInsets.all(5),
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('new ID',
                                      style: TextStyle(color: Colors.blue)),
                                  Divider(color: Colors.blue),
                                  Text(
                                    '${widget.id}',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ]))),
                    TextFormField(
                      controller: _namecontroller,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'patient name',
                        labelText: 'Name *',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'patient name couldnt be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _agecontroller,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_view_day),
                        hintText: 'patient age',
                        labelText: 'age *',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'patient age couldnt be empty';
                        }
                        return null;
                      },
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextButton(
                            onPressed: () async {
                              List<File> uris = await picker();
                              print(uris);
                              setState(() {
                                statements = uris;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'add statements',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.photo)
                              ],
                            ))),
                    statements != null
                        ? Container(
                            color: Colors.grey[200],
                            height: 500,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: statements.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.all(5),
                                      child: SizedBox(
                                          height: 480,
                                          child:
                                              Image.file(statements[index])));
                                }))
                        : Container(
                            color: Colors.grey[200],
                            height: 50,
                            child: Center(
                                child: Text(
                              'no statements added',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ))),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextButton(
                            onPressed: () async {
                              List<File> uris = await picker();
                              print(uris);
                              setState(() {
                                examinations = uris;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'add examinations',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.photo)
                              ],
                            ))),
                    examinations != null
                        ? Container(
                            color: Colors.grey[200],
                            height: 500,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: examinations.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.all(5),
                                      child: SizedBox(
                                          height: 480,
                                          child:
                                              Image.file(examinations[index])));
                                }))
                        : Container(
                            color: Colors.grey[200],
                            height: 50,
                            child: Center(
                                child: Text(
                              'no examinations added',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ))),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextButton(
                            onPressed: () async {
                              List<File> uris = await picker();
                              print(uris);
                              setState(() {
                                operations = uris;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'add operations',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.photo)
                              ],
                            ))),
                    operations != null
                        ? Container(
                            color: Colors.grey[200],
                            height: 500,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: operations.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.all(5),
                                      child: SizedBox(
                                          height: 480,
                                          child:
                                              Image.file(operations[index])));
                                }))
                        : Container(
                            color: Colors.grey[200],
                            height: 50,
                            child: Center(
                                child: Text(
                              'no operations added',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ))),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            String patientInfo =
                                _namecontroller.text.replaceAll(' ', '_') +
                                    '#' +
                                    widget.id +
                                    "-";
                            String sheetname =
                                '$dir\\${year}data\\sheets\\$patientInfo';
                            newstatements = await saveSheets(
                                sheetname + 'statements', statements);
                            newexaminations = await saveSheets(
                                sheetname + 'examinations', examinations);
                            newoperations = await saveSheets(
                                sheetname + 'operations', operations);
                            addPatient(Patient(
                                id: Hive.box('testbox').length.toString(),
                                date:
                                    DateTime.now().toString().substring(0, 10),
                                name: _namecontroller.text,
                                age: _agecontroller.text,
                                statements: newstatements,
                                examinations: newexaminations,
                                operations: newoperations));
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content:
                                    Text('patient data added successfully')));
                          }
                        },
                        child: Text('SAVE'),
                      ),
                    ),
                  ],
                ),
              ),
            ]))));
  }
}
