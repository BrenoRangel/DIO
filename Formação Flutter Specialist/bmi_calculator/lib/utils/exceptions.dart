import 'package:bmi_calculator/persistence/shared_preferences.dart';
import 'package:bmi_calculator/utils/extensions.dart';

class InvalidPersonHeightException implements Exception {
  final String height;

  const InvalidPersonHeightException(this.height);

  @override
  String toString() => '$kInvalidPersonHeight: $height'.asDanger;
}

class InvalidPersonNameException implements Exception {
  final String name;

  const InvalidPersonNameException(this.name);

  @override
  String toString() {
    return '$kInvalidPersonName: $name'.asDanger;
  }
}

class InvalidPersonWeightException implements Exception {
  final String weight;

  const InvalidPersonWeightException(this.weight);

  @override
  String toString() => '$kInvalidPersonWeight: $weight'.asDanger;
}
