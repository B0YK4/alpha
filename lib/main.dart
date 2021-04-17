import 'dart:convert';
import 'dart:io';

import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/add_patient.dart';
import 'package:alpha/screens/patient_detials.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';

final String dir = path.current;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(dir);
  new Directory('$dir\\assets').create();
  Hive.init("$dir\\db");
  var box = await Hive.openBox("testbox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'alpha Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final patientBox = Hive.box("testbox");
  void picker() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    //final path = (await getTemporaryDirectory()).path;

    if (result != null) {
      List<File> files = result.paths.map((_path) => File(_path)).toList();
      /*PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
      */
      File image = files[0];

      final File newImage = await image.copy('$dir\\assets\\image1.jpg');

      print(newImage);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
          title: Text(widget.title),
        ),
        body: WatchBoxBuilder(
            box: Hive.box('testbox'),
            builder: (context, contactsBox) {
              return ListView.builder(
                  itemCount: patientBox.length,
                  itemBuilder: (context, index) {
                    print(patientBox.get(index));
                    final Patient patient =
                        Patient.fromJson(jsonDecode(patientBox.get(index)));
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => PatientDetails(
                                        id: '${patient.id.toString()}',
                                        name: "${patient.name.toString()}",
                                        age: "${patient.age.toString()}",
                                      )));
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              elevation: 3,
                              child: ListTile(
                                leading: FlutterLogo(size: 72.0),
                                title: Text('${patient.name.toString()}'),
                                subtitle: Text('${patient.age.toString()}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                ),
                                isThreeLine: true,
                              ),
                            )));
                  });
            }),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AddPatient(
                            id: '21-00001',
                          )));
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              picker();
            },
            tooltip: '',
            child: Icon(Icons.image),
          ),
        ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.box("testbox").close();
    super.dispose();
  }
}
