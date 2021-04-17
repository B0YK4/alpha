import 'dart:convert';

import 'package:alpha/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddPatient extends StatefulWidget {
  final String id;
  AddPatient({this.id});
  @override
  _AddPatientState createState() => _AddPatientState();
}

// add new patient
void addPatient(Patient patient) async {
  final patientsBox = Hive.box('testbox');
  patientsBox.add(jsonEncode(patient));
}

class _AddPatientState extends State<AddPatient> {
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("id: ${widget.id}"),
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
                      return 'Please enter some text';
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
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        //
                        addPatient(Patient(
                            id: Hive.box('testbox').length + 1,
                            name: _namecontroller.text,
                            age: int.parse(_agecontroller.text)));
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Processing Data')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
