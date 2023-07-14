import 'dart:io';

import 'package:bmi_calculator/bmi/bmi.dart';
import 'package:bmi_calculator/models/person.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:bmi_calculator/utils/exceptions.dart';
import 'package:bmi_calculator/utils/extensions.dart';
import 'package:bmi_calculator/utils/utils.dart';
import 'package:bmi_calculator/utils/validation.dart';

void main(List<String> arguments) {
  late final Person person;
  late final double bmi;
  late final String classification;

  late final String nameInput;
  late final String weightInput;
  late final String heightInput;

  if (arguments.isEmpty) {
    print("\nInput: ${horizontalBar * (terminalLength - "Input".length)}\n");
    print("→ Enter your name:\n");
    nameInput = stdin.readLineSync()!;
    print("\n→ Enter your weight:\n");
    weightInput = stdin.readLineSync()!;
    print("\n→ Enter your height:\n");
    heightInput = stdin.readLineSync()!;
  } else if (arguments.length != 3) {
    throw Exception("This program requires 3 parameters for a Person's name, weight an height".asDanger);
  } else {
    nameInput = arguments[0];
    weightInput = arguments[1];
    heightInput = arguments[2];
  }

  if (!isValidName(nameInput)) throw InvalidPersonNameException(nameInput);
  if (double.tryParse(weightInput) == null) throw InvalidPersonWeightException(weightInput);
  if (double.tryParse(heightInput) == null) throw InvalidPersonHeightException(heightInput);

  person = Person(
    name: nameInput,
    weight: double.tryParse(weightInput)!,
    height: double.tryParse(heightInput)!,
  );

  bmi = BMI.calculate(person.weight, person.height);
  classification = BMI.classify(bmi);

  final formattedClassification = getTerminalColoredTextByClassification(classification);

  print("\nOutput: ${horizontalBar * (terminalLength - "Output".length)}\n");
  print("Name: ${person.name}");
  print("Weight: ${person.weight}");
  print("Height: ${person.height}");
  print("BMI: $bmi");
  print("Classification: $formattedClassification");
  print("\n${horizontalBar * (terminalLength + 2)}");
}
