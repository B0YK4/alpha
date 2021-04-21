import 'dart:convert';
import 'dart:io';

import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/add_patient.dart';
import 'package:alpha/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

final String dir = path.current;
final String year = DateTime.now().toString().substring(2, 5);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(dir);
  Hive.init("$dir\\${year}data\\db");
  new Directory('$dir\\${year}data').create();
  new Directory('$dir\\${year}data\\sheets').create();

  var box = await Hive.openBox("testbox");
  runApp(Home());
}
