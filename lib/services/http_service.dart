import 'dart:convert';

import 'package:http/http.dart';
import 'package:ng_demo_homework/models/employee_model.dart';
import 'package:ng_demo_homework/models/employee_res_model.dart';
class Network {
  static String BASE = "dummy.restapiexample.com";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };


  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
  /* Http Apis*/
  static String API_EMPLOYEE_LIST = "/api/v1/employees";
  static String API_EMPLOYEE_CREATE = "/api/v1/create";
  static String API_EMPLOYEE_UPDATE = "/api/v1/update"; //{id}
  static String API_EMPLOYEE_DELETE = "/api/v1/delete"; //{id}




  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Employees employee) {
    Map<String, String> params = new Map();
    params.addAll({
      'employeeName': employee.employeeName.toString(),
      'employeeSalary': employee.employeeSalary.toString(),
      'employeeAge':employee.employeeAge.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Employees employee) {
    Map<String, String> params = {};
    params.addAll({
      'id': employee.id.toString(),
      'employeeName': employee.employeeName.toString(),
      'employeeSalary':employee.employeeSalary.toString(),
      'employeeAge': employee.employeeAge.toString(),
    });
    return params;
  }
  static List<Employees>?parseEmployee(String response){
    dynamic json =jsonDecode(response);
    return EmployeeRes.fromJson(json).data;
  }


  }


