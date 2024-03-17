import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_demo_homework/models/employee_model.dart';

import '../services/http_service.dart';
import '../services/log_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  _createPost() async{
    String name = _nameController.text.toString().trim();
    String age = _ageController.text.toString().trim();

    Employees employees = Employees(employeeName: name,employeeAge: int.parse(age));

    var response = await Network.POST(Network.API_EMPLOYEE_CREATE, Network.paramsCreate(employees));
    LogService.d(response!);
    //PostRes postRes = Network.parsePostRes(response);
    backToFinish();
  }

  backToFinish(){
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("Create Post"),
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: "name"
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                        hintText: "age"
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        _createPost();
                      },
                      child: Text("Create"),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}