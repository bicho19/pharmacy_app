import 'package:pharmacy_app/src/store/models/medicament.dart';
import 'package:pharmacy_app/src/store/models/patient.dart';

class Prescription {
  int id;
  int reduction;
  double posologie;
  DateTime createdAt;
  double dosage;
  double volumeAadministrer;
  double type_poche;
  Medicament medicament;
  Patient patient;


  Prescription({
    this.id,
    this.createdAt,
    this.reduction,
    this.posologie,
    this.dosage,
    this.volumeAadministrer,
    this.type_poche,
    this.medicament,
    this.patient,
  });

  factory Prescription.fromMap(Map<String, dynamic> map){
    print(map);
    return Prescription(
      id: map['pres_id'],
      reduction: map['reduction'],
      posologie: double.parse(map['posologie'].toString()),
      createdAt: DateTime.parse(map['pres_createdAt'].toString()),
      dosage: double.parse(map['dosage'].toString()),
      volumeAadministrer: double.parse(map['volum_a_administrer'].toString()),
      type_poche: double.parse(map['type_poche'].toString()),
      medicament: map['med_name'] != null && map['labo'] != null ? Medicament(
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
      ) : null,
      patient: map['pat_id'] != null && map['full_name'] != null ? Patient(
        id: map['pat_id'],
        name: map['full_name'],
        height: double.parse(map['height'].toString()),
        weight: double.parse(map['weight'].toString()),
        surface: double.parse(map['surface'].toString()),
      ) : null,
    );
  }

  Map<String, dynamic> saveToMap(){
    return <String, dynamic>{
      "reduction": this.reduction,
      "posologie": this.posologie,
      "pres_createdAt": this.createdAt.toIso8601String(),
      "dosage": this.dosage,
      "volum_a_administrer": this.volumeAadministrer,
      "type_poche": this.type_poche,
      "medicament_id": this.medicament.id ?? 0,
      "patient_id": this.patient.id ?? 0,
    };
  }

  String getIndex(int index) {
    switch (index) {
      case 0:
        return this.id.toString();
      case 1:
        return this.medicament?.name?.toString();
      case 2:
        return this.volumeAadministrer.toStringAsFixed(2).toString()+" mg/ml";
      case 3:
        return this.dosage.toString();
      case 4:
        return this.patient?.name?.toString();
    }
    return '';
  }
}