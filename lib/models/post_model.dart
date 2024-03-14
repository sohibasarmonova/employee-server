
class Employee{
  int? id;
  String? employeeName;
  String? employeeSalary;
  int? employeeAge;

  Employee({this.id, this.employeeName, this.employeeSalary, this.employeeAge});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'employeeName': employeeName,
      'employeeSalary': employeeSalary,
      'employeeAge': employeeAge,
    };
  }

  static Employee fromMap(Map map){
    Employee employee=Employee();
    employee.id=map["id"];
    employee.employeeName=map["employeeName"];
    employee.employeeSalary=map["employeeSalary"];
    employee. employeeAge=map[" employeeAge"];
    return employee;
  }
}