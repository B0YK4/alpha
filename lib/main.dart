import 'dart:io';

import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;

final String dir = path.current;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(dir);
  Hive.init("$dir\\ClinicData\\db");
  new Directory('$dir\\ClinicData').create();
  new Directory('$dir\\ClinicData\\sheets').create();
  var box = await Hive.openBox("testbox");

  runApp(Home());
}
