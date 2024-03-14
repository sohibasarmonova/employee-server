import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ng_demo_homework/models/post_model.dart';
import 'package:ng_demo_homework/services/log_service.dart';
import 'package:http/http.dart' as http;

import '../services/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = "no data";
  List<Employee> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //LogService.d("hi there-d");
    // LogService.i("hi there-i");
    //LogService.w("hi there-w");
    // LogService.e("hi there-e");
    //loadPosts();
     //createPost();
    updatePost();
   // deletePost();
  }

  loadPost() async {
    var url = Uri.https('dummy.restapiexample.com', 'api/v1/employees');
    var response = await http.get(url);
    LogService.d(response.body);
  }

  loadPosts() async {
    var response = await Network.GET(Network.API_EMPLOYEE_LIST, {});
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  createPost() async {
    Employee employee = Employee(
        id: 1,
        employeeName: "Nextgen",
        employeeSalary: "Academy",
        employeeAge: 25);
    var response = await Network.POST(
        Network.API_EMPLOYEE_CREATE, Network.paramsCreate(employee));
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  updatePost() async {
    Employee employee = Employee(
        id: 1,
        employeeName: "Nextgen 2",
        employeeSalary: "Academy 2",
        employeeAge: 25);
    var response = await Network.PUT(
        Network.API_EMPLOYEE_UPDATE + employee.id.toString(),
        Network.paramsUpdate(employee));
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  deletePost() async {
    Employee employee = Employee(
        id: 1,
        employeeName: "Nextgen 2",
        employeeSalary: "Academy 2",
        employeeAge: 25);
    var response = await Network.DEL(
        Network.API_EMPLOYEE_DELETE + employee.id.toString(),
        Network.paramsEmpty());
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Emploee"),
      ),
      body: Center(
        child: Text(
          data,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
