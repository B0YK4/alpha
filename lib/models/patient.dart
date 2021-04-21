import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  final String id;
  final String date;
  final String name;
  final String age;
  final List<String> operations;
  final List<String> examinations;
  final List<String> statements;

  Patient(
      {this.id,
      this.date,
      this.name,
      this.age,
      this.operations,
      this.examinations,
      this.statements});

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
