import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'students.dart';
import 'crud_operations.dart';
import 'dart:async';
import 'insert.dart';
import 'update.dart';
import 'delete.dart';
import 'select.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {
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
  final _scaffoldkey=GlobalKey<ScaffoldState>();
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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Center(
                child: Text(
                  "MENU",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(color: Colors.pink),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('INSERT'), onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => inserta()));
              },

            ),
            ListTile(
              leading: Icon(Icons.update),
              title: Text('UPDATE'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => update()));
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('BUSCAR'),
             onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => select()));
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('DELETE'),
             onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => delete()));
              },
            ),
          ],
        ),
      ),
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text("Basic SQL operations"),
        centerTitle: true,
        backgroundColor: Colors.red,
        //ACTUALIZAR LOS DATOS INGRESADOS EN EL MAIN
        leading: IconButton(
          icon: Icon(Icons.system_update_alt),
          onPressed: (){
            setState(() {
             refreshList();
            });
          },
        ),
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
         // DataCell(Text(student.controlum.toString())),
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
            return Text("Not data founded");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }


  _snack(BuildContext context, String texto) {
    final snackbar = SnackBar(
      content: new Text(texto),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }
}