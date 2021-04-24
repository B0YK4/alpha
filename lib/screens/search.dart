import 'package:alpha/models/patient.dart';
import 'package:alpha/screens/edit_patient.dart';
import 'package:alpha/screens/patient_detials.dart';
import 'package:flutter/material.dart';

class BuildSearch extends SearchDelegate {
  BuildSearch(this.patients);
  final List<Patient> patients;

  final List<Patient> patientsHistory = [];
  List<Patient> suggestions;
  String dropdownValue = 'ID';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
        ),
        onPressed: () {
          query = "";
        },
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Colors.grey[200],
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.blue.shade400),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String newValue) {
                  dropdownValue = newValue;
                },
                items: <String>['ID', 'Name', 'Age']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              )))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return SearchList(suggestions);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestions = patients;
    switch (dropdownValue) {
      case 'ID':
        {
          suggestions = query.isEmpty
              ? patients
              : patients
                  .where((element) =>
                      element.id.toLowerCase().startsWith(query.toLowerCase()))
                  .toList();
        }
        break;

      case 'Name':
        {
          suggestions = query.isEmpty
              ? patients
              : patients
                  .where((element) =>
                      element.name.toLowerCase().contains(query.toLowerCase()))
                  .toList();
        }
        break;
      case 'Age':
        {
          suggestions = query.isEmpty
              ? patients
              : patients
                  .where((element) => element.age
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }

    if (suggestions != null)
      return SearchList(suggestions);
    else {
      return Center(
        child: Text('no Patients'),
      );
    }
  }
}

class SearchList extends StatelessWidget {
  final List<Patient> patients;
  SearchList(this.patients);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientDetails(
                                  index: index,
                                  patient: patients[index],
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
                                            style:
                                                TextStyle(color: Colors.blue)),
                                        Divider(color: Colors.blue),
                                        Text(
                                          '${patients[index].id}',
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ]))),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text('${patients[index].name.toString()}',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black87)),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('${patients[index].age.toString()}',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 20)),
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
                                            patient: patients[index],
                                          )));
                            },
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ]),
                      )));
            }));
  }
}
