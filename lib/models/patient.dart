import 'dart:convert';

class Patient {
  final int id;
  final String name;
  final int age;
  Patient({this.id, this.name, this.age});
  factory Patient.fromJson(json) {
    return Patient(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
      };
}
