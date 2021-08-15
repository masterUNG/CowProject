import 'dart:convert';

class CowDataModel {
  final int age;
  final String dateChoose;
  final String gendle;
  final String idCode;
  final String pathImage;
  final String type;
  final String uidRecord;
  CowDataModel({
    required this.age,
    required this.dateChoose,
    required this.gendle,
    required this.idCode,
    required this.pathImage,
    required this.type,
    required this.uidRecord,
  });

  CowDataModel copyWith({
    int? age,
    String? dateChoose,
    String? gendle,
    String? idCode,
    String? pathImage,
    String? type,
    String? uidRecord,
  }) {
    return CowDataModel(
      age: age ?? this.age,
      dateChoose: dateChoose ?? this.dateChoose,
      gendle: gendle ?? this.gendle,
      idCode: idCode ?? this.idCode,
      pathImage: pathImage ?? this.pathImage,
      type: type ?? this.type,
      uidRecord: uidRecord ?? this.uidRecord,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'dateChoose': dateChoose,
      'gendle': gendle,
      'idCode': idCode,
      'pathImage': pathImage,
      'type': type,
      'uidRecord': uidRecord,
    };
  }

  factory CowDataModel.fromMap(Map<String, dynamic> map) {
    return CowDataModel(
      age: map['age'],
      dateChoose: map['dateChoose'],
      gendle: map['gendle'],
      idCode: map['idCode'],
      pathImage: map['pathImage'],
      type: map['type'],
      uidRecord: map['uidRecord'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CowDataModel.fromJson(String source) => CowDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CowDataModel(age: $age, dateChoose: $dateChoose, gendle: $gendle, idCode: $idCode, pathImage: $pathImage, type: $type, uidRecord: $uidRecord)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CowDataModel &&
      other.age == age &&
      other.dateChoose == dateChoose &&
      other.gendle == gendle &&
      other.idCode == idCode &&
      other.pathImage == pathImage &&
      other.type == type &&
      other.uidRecord == uidRecord;
  }

  @override
  int get hashCode {
    return age.hashCode ^
      dateChoose.hashCode ^
      gendle.hashCode ^
      idCode.hashCode ^
      pathImage.hashCode ^
      type.hashCode ^
      uidRecord.hashCode;
  }
}
