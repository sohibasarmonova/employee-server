class Employees{
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;


  Employees({
    this.id,
     this.employeeName,
    this.employeeSalary,
     this.employeeAge,
  });

  factory Employees.fromJson(Map<String, dynamic> json) =>Employees(
    id: json["id"],
    employeeName: json["employee_name"],
    employeeSalary: json["employee_salary"],
    employeeAge: json["employee_age"],
  );



  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_name": employeeName,
    "employee_salary": employeeSalary,
    "employee_age": employeeAge,

  };
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeName': employeeName,
      'employeeSalary': employeeSalary,
      'employeeAge': employeeAge
    };
  }

  static Employees fromMap(Map map) {
    Employees employee = Employees();
    employee.id = map['id'];
    employee.employeeName = map['employeeName'];
    employee.employeeSalary = map['employeeSalary'];
    employee.employeeAge = map['employeeAge'];
    return employee;
  }
}