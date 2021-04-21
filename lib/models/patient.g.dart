// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    id: json['id'] as String,
    date: json['date'] as String,
    name: json['name'] as String,
    age: json['age'] as String,
    operations: (json['operations'] as List)?.map((e) => e as String)?.toList(),
    examinations:
        (json['examinations'] as List)?.map((e) => e as String)?.toList(),
    statements: (json['statements'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'name': instance.name,
      'age': instance.age,
      'operations': instance.operations,
      'examinations': instance.examinations,
      'statements': instance.statements,
    };
