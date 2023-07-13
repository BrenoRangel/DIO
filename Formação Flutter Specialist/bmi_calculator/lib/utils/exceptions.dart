import 'package:bmi_calculator/utils/extensions.dart';

class InvalidPersonNameException implements Exception {
  final String name;

  const InvalidPersonNameException(this.name);

  @override
  String toString() {
    return 'Invalid person name: $name'.asDanger;
  }
}

class InvalidPersonWeightException implements Exception {
  final String weight;

  const InvalidPersonWeightException(this.weight);

  @override
  String toString() => 'Invalid person weight: $weight'.asDanger;
}

class InvalidPersonHeightException implements Exception {
  final String height;

  const InvalidPersonHeightException(this.height);

  @override
  String toString() => 'Invalid person height: $height'.asDanger;
}
