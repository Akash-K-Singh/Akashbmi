class BmiDataModel {
  final int? id;
  final String date;
  final int weight;
  final int feets;
  final int inches;
  final String bmiValue;

  BmiDataModel({
    this.id,
    required this.date,
    required this.weight,
    required this.feets,
    required this.inches,
    required this.bmiValue,
  });

  BmiDataModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        date = map['date'],
        weight = map['weight'],
        feets = map['feets'],
        inches = map['inches'],
        bmiValue = map['bmiValue'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'date': date,
      'weight': weight,
      'feets': feets,
      'inches': inches,
      'bmiValue': bmiValue,
    };
  }
}
