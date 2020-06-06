class Student{
  int controlum;
  String name;
  String surname_p;
  String surname_m;
  String mar;
  String email;
  String num;
  Student(this.controlum, this.name, this.surname_m, this.surname_p, this.mar, this.email, this.num);
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      'controlum':controlum,
      'name':name,
      'surname_m':surname_p,
      'surname_p':surname_m,
      'mar':mar,
      'email':email,
      'num':num
    };
    return map;
  }
  Student.fromMap(Map<String,dynamic> map){
    controlum=map['controlum'];
    name=map['name'];
    surname_m=map['surname_m'];
    surname_p=map['surname_p'];
    mar=map['mar'];
    email=map['email'];
    num=map['num'];
  }
}