class Patient  {
  final int id;
  final String name;
  final double height;
  final double weight;
  final double surface;

  Patient({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.surface,
  });

  factory Patient.fromMap(Map<String, dynamic> data){
    return Patient(
     id: data['pat_id'],
     name: data['full_name'],
     height: double.parse(data['height'].toString()),
     weight: double.parse(data['weight'].toString()),
     surface: double.parse(data['surface'].toString()),

    );
  }
  Map<String, dynamic> saveToJson(){
    return {
      "full_name": this.name,
      "height": this.height,
      "weight": this.weight,
      "surface": this.surface
    };
  }

  bool isEqual(Patient model) {
    return this?.id == model?.id;
  }


}