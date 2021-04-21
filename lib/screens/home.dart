import 'dart:convert';

import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/add_patient.dart';
import 'package:alpha/screens/patient_detials.dart';
import 'package:alpha/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                //Navigator.pop(context);
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
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
          title: Text(widget.title),
        ),
        body: WatchBoxBuilder(
            box: Hive.box('testbox'),
            builder: (context, contactsBox) {
              return ListView.builder(
                  itemCount: patientBox.length,
                  itemBuilder: (context, index) {
                    print(
                        '=============================================================================');
                    print(patientBox.get(index));
                    print(jsonDecode(patientBox.get(index)));
                    final Patient patient =
                        Patient.fromJson(jsonDecode(patientBox.get(index)));
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientDetails(
                                        patient: patient,
                                      )));
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              elevation: 1,
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
                            id: '$year${Hive.box('testbox').length}',
                          )));
            },
            tooltip: 'Add new patient',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 30,
          ),
        ]));
  }
}
