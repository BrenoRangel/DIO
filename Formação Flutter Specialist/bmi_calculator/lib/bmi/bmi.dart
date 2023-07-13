import 'bmi_classification.dart';

abstract class BMI {
  static double calculate(double weight, double height) => weight / (height * height);

  static String classify(double bmi) => switch (bmi) {
        < 16 => BMIClassification.severeThinness.toString(),
        >= 16 && < 17 => BMIClassification.moderateThinness.toString(),
        >= 17 && < 18.5 => BMIClassification.mildThinness.toString(),
        >= 18.5 && < 25 => BMIClassification.normalRange.toString(),
        >= 25 && < 30 => BMIClassification.overweight.toString(),
        >= 30 && < 35 => BMIClassification.obeseClassI.toString(),
        >= 35 && < 40 => BMIClassification.obeseClassII.toString(),
        _ => BMIClassification.obeseClassIII.toString()
      };
}
