import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'students.dart';
import 'crud_operations.dart';
import 'main.dart';

class inserta extends StatefulWidget {
  @override
  _inserta createState() => new _inserta();
}
class _inserta extends State<inserta> {
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
  final formkey = new GlobalKey<FormState>();

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

  void dataValidate() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (isUpdating) {
        Student stu = Student(currentUserId, name, surname_p, surname_m, mar, email, num);
        bdHelper.update(stu);
        setState(() {
          isUpdating = false;
        });
      } else {
        Student stu = Student(null, name, surname_p, surname_m, mar, email, num);
        var validation = await bdHelper.validateInsert(stu);
        print(validation);
        if (validation) {
          bdHelper.insert(stu);
          final snackbar = SnackBar(
            content: new Text("DATOS INGRESADOS!"),
            backgroundColor: Colors.deepPurple,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        } else {
          final snackbar = SnackBar(
            content: new Text("LA MATRICULA YA FUE REGISTRADA!"),
            backgroundColor: Colors.deepPurple,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        }
      }
      cleanData();
      refreshList();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("INSERCION"),
        backgroundColor: Colors.pink,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              TextFormField(
                controller: controllerN,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Student Name"),
                validator: (val) => val.length == 0 ? 'Enter name' : null,
                onSaved: (val) => name = val,
              ),
              TextFormField(
                controller: controllerS,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Student Surname1"),
                validator: (val) => val.length == 0 ? 'Enter surname1' : null,
                onSaved: (val) => surname_p = val,
              ),
              TextFormField(
                controller: controllerS2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Student Surname2"),
                validator: (val) => val.length == 0 ? 'Enter surname2' : null,
                onSaved: (val) => surname_m = val,
              ),
              TextFormField(
                controller: controllerM,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Matricula"),
                validator: (val) => val.length == 0 ? 'Enter matricula' : null,
                onSaved: (val) => mar = val,
              ),
              TextFormField(
                controller: controllerE,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Student Mail"),
                validator: (val) => !val.contains('@') ? 'Enter mail' : null,
                onSaved: (val) => email = val,
              ),
              TextFormField(
                controller: controllerT,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Student phone"),
                validator: (val) =>
                val.length < 10 ? 'Enter phone number' : null,
                onSaved: (val) => num = val,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.pinkAccent)),
                    onPressed: dataValidate,
                    child: Text(isUpdating ? 'Update' : 'Add Data'),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.pink)),
                    onPressed: () {
                      setState(() {
                        isUpdating = false;
                      });
                      cleanData();
                    },
                    child: Text('Cancel'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
