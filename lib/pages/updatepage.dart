import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_demo_homework/models/employee_model.dart';

import '../services/http_service.dart';
import '../services/log_service.dart';

class UpdatePage extends StatefulWidget {
  final Employees employees;
  const UpdatePage({super.key,required this.employees});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();


  _updatePost() async{
    String name = _nameController.text.toString().trim();
    String age = _ageController.text.toString().trim();

    Employees newEmployee = widget.employees;
    newEmployee.employeeName = name;
    newEmployee.employeeAge = int.parse(age);

    var response = await Network.PUT(Network.API_EMPLOYEE_UPDATE + newEmployee.id.toString(), Network.paramsUpdate(newEmployee));
    LogService.d(response!);
   // PostRes postRes = Network.parsePostRes(response);

    backToFinish();
  }

  backToFinish(){
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.employees.employeeName!;
    _ageController.text = widget.employees.employeeAge.toString();
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
            title: Text("Update Post"),
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
                        hintText: "Title"
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                        hintText: "Body"
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        _updatePost();
                      },
                      child: Text("Update"),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }

}