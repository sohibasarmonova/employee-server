// To parse this JSON data, do
//
//     final postRes = postResFromJson(jsonString);

import 'dart:convert';

import 'package:ng_demo_homework/models/employee_model.dart';

EmployeeRes postResFromJson(String str) =>  EmployeeRes.fromJson(json.decode(str));

String postResToJson( EmployeeRes data) => json.encode(data.toJson());

class EmployeeRes {
  String? status;
  List<Employees>? data;
  String? message;

  EmployeeRes({
     this.status,
     this.data,
    this.message,
  });

  factory  EmployeeRes.fromJson(Map<String, dynamic> json) =>  EmployeeRes(
    status: json["status"],
    data: List<Employees>.from(json["data"].map((x) => Employees.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}




