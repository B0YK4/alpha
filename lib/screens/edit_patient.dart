import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/show_image.dart';
import 'package:alpha/services/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:alpha/main.dart';

class EditPatient extends StatefulWidget {
  final Patient patient;
  final int index;
  EditPatient({this.patient, this.index});
  @override
  _EditPatientState createState() => _EditPatientState();
}

List<String> operations = [];
List<String> examinations = [];
List<String> statements = [];
List<String> newstatements;
List<String> newexaminations;
List<String> newoperations;

void editPatient(int _index, Patient patient) async {
  final patientsBox = Hive.box('testbox');
  print('===============patient==json=================');

  print(patient.toJson());
  patientsBox.putAt(_index, json.encode(patient.toJson()));
}

Future<List<String>> saveSheets(String sheetname, List<String> sheets) async {
  if (sheets == null) return null;
  List<String> newsheets = [];
  for (int ctr = 0; ctr < sheets.length; ctr++) {
    final File newImage = await File(sheets[ctr]).copy('$sheetname$ctr.jpg');
    newsheets.add(newImage.path);
  }
  return newsheets;
}

class _EditPatientState extends State<EditPatient> {
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _namecontroller.text = widget.patient.name;
    _agecontroller.text = widget.patient.age;
    statements = widget.patient.statements;
    operations = widget.patient.operations;
    examinations = widget.patient.examinations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Column(children: [
          Expanded(
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
                          padding: EdgeInsets.all(15),
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
                                    Text('ID',
                                        style: TextStyle(color: Colors.blue)),
                                    Divider(color: Colors.blue),
                                    Text(
                                      '${widget.patient.id}',
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ]))),
                      TextFormField(
                        controller: _namecontroller,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'patient name',
                          labelText: 'edit Name',
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
                          labelText: 'edit age',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'patient age couldnt be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Divider(
                        color: Colors.blue,
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: TextButton(
                              onPressed: () async {
                                String uris = picker();
                                print(uris);
                                setState(() {
                                  statements.add(uris);
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
                      statements.isNotEmpty
                          ? Container(
                              color: Colors.grey[200],
                              height: 300,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: statements.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            fullscreenDialog:
                                                                true,
                                                            builder: (context) =>
                                                                ShowImage(File(
                                                                    statements[
                                                                        index]))));
                                                  },
                                                  child: SizedBox(
                                                      height: 260,
                                                      child: Image.file(File(
                                                          statements[index])))),
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      statements
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: Text(
                                                    'delete',
                                                    style: TextStyle(
                                                        color: Colors.red[300],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ]));
                                  }))
                          : Container(
                              color: Colors.grey[200],
                              height: 50,
                              child: Center(
                                  child: Text(
                                'no statements added',
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 15),
                              ))),
                      Divider(
                        color: Colors.blue,
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: TextButton(
                              onPressed: () {
                                String uris = picker();
                                print(uris);
                                setState(() {
                                  examinations.add(uris);
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
                      examinations.isNotEmpty
                          ? Container(
                              color: Colors.grey[200],
                              height: 300,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: examinations.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            fullscreenDialog:
                                                                true,
                                                            builder: (context) =>
                                                                ShowImage(File(
                                                                    examinations[
                                                                        index]))));
                                                  },
                                                  child: SizedBox(
                                                      height: 260,
                                                      child: Image.file(File(
                                                          examinations[
                                                              index])))),
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      examinations
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: Text(
                                                    'delete',
                                                    style: TextStyle(
                                                        color: Colors.red[300],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ]));
                                  }))
                          : Container(
                              color: Colors.grey[200],
                              height: 50,
                              child: Center(
                                  child: Text(
                                'no examinations added',
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 15),
                              ))),
                      Divider(
                        color: Colors.blue,
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: TextButton(
                              onPressed: () {
                                String uris = picker();
                                print(uris);
                                setState(() {
                                  operations.add(uris);
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
                      operations.isNotEmpty
                          ? Container(
                              color: Colors.grey[200],
                              height: 300,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: operations.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            fullscreenDialog:
                                                                true,
                                                            builder: (context) =>
                                                                ShowImage(File(
                                                                    operations[
                                                                        index]))));
                                                  },
                                                  child: SizedBox(
                                                      height: 260,
                                                      child: Image.file(File(
                                                          operations[index])))),
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      operations
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: Text(
                                                    'delete',
                                                    style: TextStyle(
                                                        color: Colors.red[300],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ]));
                                  }))
                          : Container(
                              color: Colors.grey[200],
                              height: 50,
                              child: Center(
                                  child: Text(
                                'no operations added',
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 15),
                              ))),
                    ],
                  ),
                ),
              ]))),
          Container(
              color: Colors.white,
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          String patientInfo =
                              _namecontroller.text.replaceAll(' ', '_') +
                                  '#' +
                                  widget.patient.id +
                                  "-";
                          String sheetname =
                              '$dir\\ClinicData\\sheets\\$patientInfo';
                          newstatements = await saveSheets(
                              sheetname + 'statements', statements);
                          newexaminations = await saveSheets(
                              sheetname + 'examinations', examinations);
                          newoperations = await saveSheets(
                              sheetname + 'operations', operations);

                          editPatient(
                              widget.index,
                              Patient(
                                  id: widget.patient.id,
                                  date: DateTime.now()
                                      .toString()
                                      .substring(0, 10),
                                  name: _namecontroller.text,
                                  age: _agecontroller.text,
                                  statements: newstatements,
                                  examinations: newexaminations,
                                  operations: newoperations));
                          Navigator.pop(
                              context,
                              Patient(
                                  id: widget.patient.id,
                                  date: DateTime.now()
                                      .toString()
                                      .substring(0, 10),
                                  name: _namecontroller.text,
                                  age: _agecontroller.text,
                                  statements: newstatements,
                                  examinations: newexaminations,
                                  operations: newoperations));

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content:
                                  Text('patient data updated successfully')));
                        }
                      },
                      child: Text('SAVE'),
                    ),
                  ),
                ],
              ))
        ])));
  }
}
