import 'dart:io';

import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/show_image.dart';
import 'package:flutter/material.dart';

class PatientDetails extends StatelessWidget {
  final Patient patient;
  PatientDetails({this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
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
                            width: 120,
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
                                    '${patient.id}',
                                    style: TextStyle(fontSize: 30),
                                  )
                                ])),
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('name: ${patient.name}',
                                      style: TextStyle(fontSize: 30)),
                                  Text('age: ${patient.age}',
                                      style: TextStyle(fontSize: 30)),
                                  Text(
                                    'Date: ${patient.date}',
                                    style: TextStyle(fontSize: 30),
                                  ),
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
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                  patient.statements != null
                      ? Container(
                          color: Colors.grey[200],
                          height: 500,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: patient.statements.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => ShowImage(
                                                  File(patient
                                                      .statements[index]))));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: SizedBox(
                                            height: 480,
                                            child: Image.file(File(
                                                patient.statements[index])))));
                              }))
                      : Container(
                          color: Colors.grey[200],
                          height: 50,
                          child: Center(
                              child: Text(
                            'no statements added',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ))),
                  Divider(color: Colors.blue),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'examinations',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                  patient.examinations != null
                      ? Container(
                          color: Colors.grey[200],
                          height: 500,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: patient.examinations.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => ShowImage(
                                                  File(patient
                                                      .examinations[index]))));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: SizedBox(
                                            height: 480,
                                            child: Image.file(File(patient
                                                .examinations[index])))));
                              }))
                      : Container(
                          color: Colors.grey[200],
                          height: 50,
                          child: Center(
                              child: Text(
                            'no examinations added',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ))),
                  Divider(color: Colors.blue),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'operations',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                  patient.operations != null
                      ? Container(
                          color: Colors.grey[200],
                          height: 500,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: patient.operations.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => ShowImage(
                                                  File(patient
                                                      .operations[index]))));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: SizedBox(
                                            height: 480,
                                            child: Image.file(File(
                                                patient.operations[index])))));
                              }))
                      : Container(
                          color: Colors.grey[200],
                          height: 50,
                          child: Center(
                              child: Text(
                            'no operations added',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ))),
                ],
              ),
            )));
  }
}
