import 'dart:io';

import 'package:flutter/material.dart';
import 'package:alpha/services/print.dart';
import 'package:printing/printing.dart';

import 'package:path_provider/path_provider.dart';

class ShowImage extends StatelessWidget {
  final File image;
  ShowImage(this.image);
  Future<String> savetodesktop(File sheet) async {
    Directory dir = await getApplicationDocumentsDirectory(); // desktop
    String path = dir.path;
    final File newImage = await sheet.copy(
        path.substring(0, path.length - 9) + "\Desktop\\patient_sheet.jpg");
    if (newImage == null) return null;
    return newImage.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Column(children: [
          Expanded(
              child: Container(
                  child: SingleChildScrollView(child: Image.file(image)))),
          ButtonBar(
            children: <Widget>[
              ElevatedButton(
                child: Text('save to Desktop'),
                onPressed: () async {
                  String newimage = await savetodesktop(image);
                  if (newimage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            'patient sheet saved successfully, path: ' +
                                newimage)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content:
                            Text('an error occurred patient sheet not saved')));
                  }
                },
              ),
              ElevatedButton(
                child: Text('print'),
                onPressed: () async {
                  print('==========print==========');
                  await Printing.layoutPdf(onLayout: (_) => printImage(image));
                },
              ),
            ],
          )
        ])));
  }
}
