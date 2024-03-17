import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:ng_demo_homework/models/employee_model.dart';
import 'package:ng_demo_homework/pages/updatepage.dart';

import '../services/http_service.dart';
import '../services/log_service.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Employees> employee = [];

  _loadEmployee() async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_EMPLOYEE_LIST,{});

    LogService.d(response!);
    employee = Network.parseEmployee(response)!;

    setState(() {
      employee= employee;
      isLoading = false;
    });
  }

  _deleteEmployee(Employees employees) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.DEL(Network.API_EMPLOYEE_DELETE + employees.id.toString(), Network.paramsEmpty());
    LogService.d(response!);
    _loadEmployee();
  }

  Future _callCreatePage() async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const CreatePage();
    }));

    if (result) {
      _loadEmployee();
    }
  }

  Future _callUpdatePage(Employees employees) async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UpdatePage(employees: employees);
    }));

    if (result) {
      _loadEmployee();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadEmployee();
  }

  Future<void> _handleRefresh() async {
    _loadEmployee();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Networking"),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView.builder(
              itemCount: employee.length,
              itemBuilder: (ctx, index) {
                return _itemOfPost(employee[index]);
              },
            ),
          ),
          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _callCreatePage();
        },
      ),
    );
  }

  Widget _itemOfPost(Employees employees) {
    return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                _callUpdatePage(employees);
              },
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.create,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                _deleteEmployee(employees);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name:${ employees.employeeName}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("age:${employees.employeeAge}",
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
              Divider(),
            ],
          ),
        ));
  }
}