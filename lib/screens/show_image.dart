import 'dart:io';

import 'package:flutter/material.dart';
import 'package:alpha/services/print.dart';
import 'package:printing/printing.dart';

class ShowImage extends StatelessWidget {
  final File image;
  ShowImage(this.image);
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
                onPressed: () {/** */},
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
