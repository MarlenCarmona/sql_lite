import 'crud_operations.dart';
import 'students.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class select extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<select> {
  //Variable referentes al manejo de la BD
  Future<List<Student>> Studentss;
  TextEditingController controllerN = TextEditingController();
  TextEditingController controllerS = TextEditingController();
  TextEditingController controllerS2 = TextEditingController();
  TextEditingController controllerE = TextEditingController();
  TextEditingController controllerT = TextEditingController();
  TextEditingController controllerM = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String name;
  String surname_m;
  String surname_p;
  String email;
  String num;
  String mar;
  int currentUserId;
  String valor;
  int opcion;

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
      Studentss = dbHelper.busqueda(searchController.text);
    });
  }
  void cleanData() {
    searchController.text = "";
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
        rows: Studentss.map((student) => DataRow(cells: [

          //NOMBRE 1

          DataCell(Text(student.name.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controllerN.text = student.name;
          }),
          //APELLIDO PATERNO 2
          DataCell(Text(student.surname_p.toString().toUpperCase()),
              onTap: () {
                setState(() {
                  isUpdating = true;
                  currentUserId = student.controlum;
                });
                controllerS.text = student.surname_p;
              }),
          //APELLIDO MATERNO 3

          DataCell(Text(student.surname_m.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controllerS2.text = student.surname_m;
          }),
          //TELEFONO 4
          DataCell(Text(student.mar.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controllerM.text = student.mar;
          }),
          DataCell(Text(student.email.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
            });
            controllerE.text = student.email;
          }),
          DataCell(Text(student.num.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              currentUserId = student.controlum;
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
    return new Scaffold(//new line
      appBar: new AppBar(
        title: isUpdating ? TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (text){
              refreshList();
            })
            : Text("Buscar datos"),
        leading: IconButton(
          icon: Icon(isUpdating ? Icons.done: Icons.search),
          onPressed: (){
            print("Is typing"+ isUpdating.toString());
            setState(() {
              isUpdating = !isUpdating;
              searchController.text = "";
            });
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
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