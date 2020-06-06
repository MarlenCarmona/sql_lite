import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'students.dart';
import 'crud_operations.dart';
import 'dart:async';

class delete extends StatefulWidget {
  @override
  _mydata createState() => new _mydata();
}

class _mydata extends State<delete> {
  //Variables referentes al manejo de la bd
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
  var bdHelper;
  bool isUpdating;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = bdHelper.getStudents();
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

  void guardar() {
    setState(() {
      _snack(context, "Datos eliminados!");
    });
  }

  //Mostrar datos
  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text("Delete")),
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

         // DataColumn(label: Text("Update"))
        ],
        rows: Studentss.map((student) => DataRow(cells: [
          DataCell(IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              bdHelper.delete(student.controlum);
              refreshList();
            },
          )),
              DataCell(
                Text(student.name.toString().toUpperCase()),
                onTap: () {
                  setState(() {
                    isUpdating = true;
                    currentUserId = student.controlum;
                  });
                  controllerN.text = student.name;
                },
              ),
              DataCell(Text(student.surname_m.toString().toUpperCase())),
              DataCell(Text(student.surname_p.toString().toUpperCase())),
              DataCell(Text(student.mar.toString().toUpperCase())),
              DataCell(Text(student.email.toString().toUpperCase())),
              DataCell(Text(student.num.toString().toUpperCase())),

            //  DataCell(IconButton(
                //icon: Icon(Icons.update),
                //onPressed: () {
                  //bdHelper.update(student.controlum);
                  //refreshList();
                //},
              //))
            ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("Not data founded");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  final formkey = new GlobalKey<FormState>();

  _snack(BuildContext context, String texto) {
    final snackbar = SnackBar(
      content: new Text(texto),
      backgroundColor: Colors.pink,
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text("Eliminar Datos"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            list(),
          ],
        ),
      ),
    );
  }
}
