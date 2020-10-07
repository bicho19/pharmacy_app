class LeftOver {

  int id;
  int medicmanet_id;
  int prescription_id;
  DateTime createdAt;
  double reliquat;


  LeftOver({
    this.id,
   this.createdAt,
   this.reliquat,
});

  factory LeftOver.fromMap(Map<String, dynamic> data){
    return LeftOver(
    id: data['leftover_id'],
      reliquat: data['reliquat'],
      createdAt: DateTime.parse(data['leftover_createdAt'].toString()),
    );
  }

  Map<String, dynamic> updateReliquat() {
    return <String, dynamic>{
      "reliquat": this.reliquat,
    };
}

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "leftover_id": this.id,
      "reliquat" : this.reliquat,
      "leftover_createdAt": this.createdAt.toIso8601String(),
    };
  }
}