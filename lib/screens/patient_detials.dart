import 'package:flutter/material.dart';

class PatientDetails extends StatelessWidget {
  final String id;
  final String name;
  final String age;
  PatientDetails({this.id, this.name, this.age});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlutterLogo(
                size: 100,
              ),
              Text(
                'ID: $id',
                style: TextStyle(fontSize: 30),
              ),
              Text('name: $name', style: TextStyle(fontSize: 30)),
              Text('age: $age', style: TextStyle(fontSize: 30)),
            ],
          ),
        ));
  }
}
