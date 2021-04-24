import 'dart:convert';
import 'package:alpha/screens/edit_patient.dart';
import 'package:crypto/crypto.dart';
import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/about.dart';
import 'package:alpha/screens/add_patient.dart';
import 'package:alpha/screens/patient_detials.dart';
import 'package:alpha/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(sha1
        .convert(utf8.encode(Hive.box('testbox').length.toString()))
        .toString()
        .substring(0, 8));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Demo Home Page',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/drawer_header.jpg'),
                    fit: BoxFit.fill),
              ),
              child: Container(),
            ),
            ListTile(
              title: Text(
                'home',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'backup',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.backup),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'about',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              },
            ),
            ListTile(
              title: Text(
                'contact developer',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.developer_mode),
              onTap: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Contact developer'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            TextButton(
                                onPressed: () async {
                                  if (await UrlLauncherPlatform.instance.canLaunch(
                                      'https://www.linkedin.com/in/mo-boyka/')) {
                                    await UrlLauncherPlatform.instance.launch(
                                      'https://www.linkedin.com/in/mo-boyka/',
                                      useSafariVC: false,
                                      useWebView: false,
                                      enableJavaScript: false,
                                      enableDomStorage: false,
                                      universalLinksOnly: false,
                                      headers: <String, String>{},
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text('LinkedIn'),
                                    Icon(Icons.link)
                                  ],
                                )),
                            TextButton(
                                onPressed: () async {
                                  if (await UrlLauncherPlatform.instance
                                      .canLaunch(
                                          'https://twitter.com/m0_boyka')) {
                                    await UrlLauncherPlatform.instance.launch(
                                      'https://twitter.com/m0_boyka',
                                      useSafariVC: false,
                                      useWebView: false,
                                      enableJavaScript: false,
                                      enableDomStorage: false,
                                      universalLinksOnly: false,
                                      headers: <String, String>{},
                                    );
                                  }
                                },
                                child: Row(
                                  children: [Text('Twitter'), Icon(Icons.link)],
                                )),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                //Navigator.pop(context);
              },
            ),
          ],
        )),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search for patient',
                onPressed: () {
                  final patientBox = Hive.box("testbox");
                  final List<Patient> patientlist = [];
                  for (var i = 0; i < patientBox.length; i++) {
                    patientlist
                        .add(Patient.fromJson(jsonDecode(patientBox.getAt(i))));
                  }
                  showSearch(
                      context: context, delegate: BuildSearch(patientlist));
                }),
            SizedBox(
              width: 30,
            )
          ],
          title: Text(widget.title),
        ),
        body: PatientList(),
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
                            id: sha1
                                .convert(utf8.encode(
                                    Hive.box('testbox').length.toString()))
                                .toString()
                                .substring(0, 8),
                          )));
            },
            tooltip: 'Add new patient',
            child: Icon(Icons.person_add),
          ),
          SizedBox(
            width: 30,
          ),
        ]));
  }
}

class PatientList extends StatelessWidget {
  final patientBox = Hive.box("testbox");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WatchBoxBuilder(
          box: Hive.box('testbox'),
          builder: (context, contactsBox) {
            return ListView.builder(
                itemCount: patientBox.length,
                itemBuilder: (context, index) {
                  print(
                      '=============================================================================');

                  print(jsonDecode(patientBox.getAt(index)));
                  final Patient patient =
                      Patient.fromJson(jsonDecode(patientBox.getAt(index)));
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientDetails(
                                      index: index,
                                      patient: patient,
                                    )));
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Card(
                            elevation: 1,
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 30, 10),
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
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                            Divider(color: Colors.blue),
                                            Text(
                                              '${patient.id}',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ]))),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text('${patient.name.toString()}',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black87)),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('${patient.age.toString()}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20)),
                                  ])),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditPatient(
                                                index: index,
                                                patient: patient,
                                              )));
                                },
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ]),
                          )));
                });
          }),
    );
  }
}
