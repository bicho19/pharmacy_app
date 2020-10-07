class Medicament {
  int id;
  String name;
  String labo;
  String date;
  int priority;
  double presentation;
  double cinitial;
  double cmin;
  double cmax;
  double volInitial;
  double prix;
  double stab;

  Medicament({
    this.id,
    this.name,
    this.labo,
    this.date,
    this.priority,
    this.presentation,
    this.cinitial,
    this.cmax,
    this.cmin,
    this.prix,
    this.stab,
    this.volInitial,
  });


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['med_id'] = id;
    }
    map['med_name'] = name;
    map['labo'] = labo;
    map['priority'] = priority;
    map['med_date'] = date;
    map['pres'] =presentation;
    map['cinit'] = cinitial;
    map['cmin'] = cmin;
    map['cmax'] = cmax;
    map['vol'] = volInitial;
    map['prix'] = prix;
    map['stab'] = stab;


    return map;
  }

  // Extract a Note object from a Map object
  factory Medicament.fromMap(Map<String, dynamic> map) {
    return Medicament(
      id: map['med_id'],
      name: map['med_name'],
      labo: map['labo'],
      cinitial: double.parse(map['cinit'].toString()),
      date: map['med_date'],
      presentation: double.parse(map['pres'].toString()),
      cmax: double.parse(map['cmax'].toString()),
      cmin: double.parse(map['cmin'].toString()),
      volInitial: double.parse(map['vol'].toString()),
      priority: int.parse(map['priority'].toString()),
      prix: double.parse(map['prix'].toString()),
      stab: double.parse(map['stab'].toString()),
    );
  }

  //custom comparing function to check if two users are equal
  bool isEqual(Medicament model) {
    return this?.id == model?.id;
  }

  String getIndex(int index) {
    switch (index) {
      case 0:
        return this.id.toString();
      case 1:
        return this.name;
      case 2:
        return this.prix.toString();
    }
    return '';
  }
}
