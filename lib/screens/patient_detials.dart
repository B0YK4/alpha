import 'dart:io';

import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/edit_patient.dart';
import 'package:alpha/screens/show_image.dart';
import 'package:flutter/material.dart';

class PatientDetails extends StatefulWidget {
  final Patient patient;
  final int index;
  PatientDetails({this.patient, this.index});
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  Patient _patient;

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditPatient(
                index: widget.index,
                patient: _patient,
              )),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    setState(() {
      _patient = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _patient = widget.patient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _navigateAndDisplaySelection(context);
                },
                icon: Icon(Icons.edit)),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(13),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.blue,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                    '${_patient.id}',
                                    style: TextStyle(fontSize: 25),
                                  )
                                ])),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text('name:',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    Text(' ${_patient.name}',
                                        style: TextStyle(fontSize: 24))
                                  ]),
                                  Row(children: [
                                    Text('Age:',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(' ${_patient.age}',
                                        style: TextStyle(fontSize: 24))
                                  ]),
                                  Row(children: [
                                    Text('Date:',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    Text(' ${_patient.date}',
                                        style: TextStyle(fontSize: 24))
                                  ]),
                                ]))
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.blue,
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'statements',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  _patient.statements.isNotEmpty
                      ? Container(
                          color: Colors.grey[200],
                          height: 300,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _patient.statements.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => ShowImage(
                                                  File(_patient
                                                      .statements[index]))));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: SizedBox(
                                            height: 280,
                                            child: Image.file(File(widget
                                                .patient.statements[index])))));
                              }))
                      : Container(
                          color: Colors.grey[200],
                          height: 50,
                          child: Center(
                              child: Text(
                            'no statements added',
                            style:
                                TextStyle(color: Colors.red[300], fontSize: 15),
                          ))),
                  Divider(color: Colors.blue),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'examinations',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  _patient.examinations.isNotEmpty
                      ? Container(
                          color: Colors.grey[200],
                          height: 300,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _patient.examinations.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => ShowImage(
                                                  File(_patient
                                                      .examinations[index]))));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: SizedBox(
                                            height: 280,
                                            child: Image.file(File(widget
                                                .patient
                                                .examinations[index])))));
                              }))
                      : Container(
                          color: Colors.grey[200],
                          height: 50,
                          child: Center(
                              child: Text(
                            'no examinations added',
                            style:
                                TextStyle(color: Colors.red[300], fontSize: 15),
                          ))),
                  Divider(color: Colors.blue),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'operations',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  _patient.operations.isNotEmpty
                      ? Container(
                          color: Colors.grey[200],
                          height: 300,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _patient.operations.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => ShowImage(
                                                  File(_patient
                                                      .operations[index]))));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: SizedBox(
                                            height: 280,
                                            child: Image.file(File(widget
                                                .patient.operations[index])))));
                              }))
                      : Container(
                          color: Colors.grey[200],
                          height: 50,
                          child: Center(
                              child: Text(
                            'no operations added',
                            style:
                                TextStyle(color: Colors.red[300], fontSize: 15),
                          ))),
                ],
              ),
            )));
  }
}
