import 'crud_operations.dart';
import 'students.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class update extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<update> {
  //Variable referentes al manejo de la BD
  Future<List<Student>> Studentss;
  TextEditingController controllerN = TextEditingController();
  TextEditingController controllerS = TextEditingController();
  TextEditingController controllerS2 = TextEditingController();
  TextEditingController controllerE = TextEditingController();
  TextEditingController controllerT = TextEditingController();
  TextEditingController controllerM = TextEditingController();
  String name;
  String surname_m;
  String surname_p;
  String email;
  String num;
  String mar;
  int currentUserId;
  String valor;
  int opcion;
  String descriptive_text = "Student Name";
  final formkey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  //select
  void refreshList() {
    setState(() {
      Studentss = dbHelper.getStudents();
    });
  }

  void cleanData() {
    controllerN.text = "";
    controllerS.text = "";
    controllerS2.text = "";
    controllerE.text = "";
    controllerT.text = "";
    controllerM.text = "";
  }

  void updateData(){
    print("Valor de Opción");
    print(opcion);
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      //NOMBRE
      if (opcion==1) {
        Student stu = Student(currentUserId, valor, surname_p, surname_m, mar, email, num);
        dbHelper.update(stu);
      }
      //APELLIDO PATERNO
      else if (opcion==2) {
        Student stu = Student(currentUserId, name, valor, surname_m,mar, email, num);
        dbHelper.update(stu);
      }
      //APELLIDO MATERNO
      else if (opcion==3) {
        Student stu = Student(currentUserId, name, surname_p,valor, mar, email, num);
        dbHelper.update(stu);
      }
      //PHONE
      else if (opcion==4) {
        Student stu = Student(currentUserId, name, surname_p, surname_m, valor, email, num);
        dbHelper.update(stu);
      }
      //EMAIL
      else if (opcion==5) {
        Student stu = Student(currentUserId, name, surname_p, surname_m,mar, valor, num);
        dbHelper.update(stu);
      }
      //MATRICULA
      else if (opcion==6) {
        Student stu = Student(currentUserId, name, surname_p,mar, surname_m, email, valor);
        dbHelper.update(stu);
      }
      cleanData();
      refreshList();
    }
  }

  void insertData() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      {
        Student stu = Student(null, name, surname_p, surname_m,mar, email, num);
        dbHelper.insert(stu);
      }
      cleanData();
      refreshList();
    }
  }
  //Formulario

  Widget form() {
    return Form(
      key: formkey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new SizedBox(height: 50.0),
            TextFormField(
              controller: controllerN,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: descriptive_text),
              validator: (val) => val.length == 0 ? 'Enter Data' : null,
              onSaved: (val) => valor = val,
            ),
            SizedBox(height: 30,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  onPressed: updateData,
                  //child: Text(isUpdating ? 'Update ' : 'Add Data'),
                  child: Text('Update Data'),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    cleanData();
                    refreshList();
                  },
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



//Mostrar datos
  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Nombre"),
          ),
          DataColumn(
            label: Text("Apellido paterno"),
          ),
          DataColumn(
            label: Text("Apellido materno"),
          ),
          DataColumn(
            label: Text("Matricula"),
          ),
          DataColumn(
            label: Text("Email"),
          ),
          DataColumn(
            label: Text("Telefono"),
          ),
        ],
        rows: Studentss.map((student) =>
            DataRow(cells: [
              //NOMBRE 1
              DataCell(Text(student.name.toString().toUpperCase()), onTap: () {
                setState(() {
                  //isUpdating = true;
                  descriptive_text = "Nombre";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname_p = student.surname_p;
                  surname_m = student.surname_m;
                  num =student.num;
                  email = student.email;
                  mar = student.mar;
                  opcion=1;
                });
                controllerN.text = student.name;
              }),
              //APELLIDO PATERNO 2
              DataCell(Text(student.surname_p.toString().toUpperCase()), onTap: () {
                setState(() {
                  //isUpdating = true;
                  descriptive_text = "Apellido_P";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname_p = student.surname_p;
                  surname_m = student.surname_m;
                  num =student.num;
                  email = student.email;
                  mar = student.mar;
                  opcion=2;
                });
                controllerS.text= student.surname_p;
              }),
              //APELLIDO MATERNO 3
              DataCell(Text(student.surname_m.toString().toUpperCase()), onTap: () {
                setState(() {
                  //isUpdating = true;
                  descriptive_text = "Apellido_m";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname_p = student.surname_p;
                  surname_m = student.surname_m;
                  num =student.num;
                  email = student.email;
                  mar = student.mar;
                  opcion=3;
                });
                controllerS2.text= student.surname_m;
              }),
              //TELEFONO 4
              DataCell(Text(student.mar.toString().toUpperCase()), onTap: () {
                setState(() {
                  //isUpdating = true;
                  descriptive_text = "Matricula";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname_p = student.surname_p;
                  surname_m = student.surname_m;
                  num =student.num;
                  email = student.email;
                  mar = student.mar;
                  opcion=4;
                });
                controllerM.text = student.mar;
              }),
              DataCell(Text(student.email.toString().toUpperCase()), onTap: () {
                setState(() {
                  //isUpdating = true;
                  descriptive_text = "Email";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname_p = student.surname_p;
                  surname_m = student.surname_m;
                  num =student.num;
                  email = student.email;
                  mar = student.mar;
                  opcion=5;
                });
                controllerE.text = student.email;
              }),
              DataCell(Text(student.num.toString().toUpperCase()), onTap: () {
                setState(() {
                  //isUpdating = true;
                  descriptive_text = "Telefono";
                  currentUserId = student.controlum;
                  name = student.name;
                  surname_p = student.surname_p;
                  surname_m = student.surname_m;
                  num =student.num;
                  email = student.email;
                  mar = student.mar;
                  opcion=6;
                });
                controllerT.text = student.num;
              }),
            ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No data founded!");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: false,   //new line
      appBar: new AppBar(
        title: Text('Actualizar Datos'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}