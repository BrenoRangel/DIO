import 'package:bmi_calculator/bmi/bmi.dart';
import 'package:bmi_calculator/bmi/bmi_classification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Given a persons's weight and height, calculate it's BMI", () {
    final bmi = BMI.calculate(80, 1.60);
    expect(bmi, equals(31.249999999999993));
  });

  test("Given a persons's BMI, get its classification", () {
    expect(BMI.classify(15), equals(BMIClassification.severeThinness.toString()));
    expect(BMI.classify(16), equals(BMIClassification.moderateThinness.toString()));
    expect(BMI.classify(17), equals(BMIClassification.mildThinness.toString()));
    expect(BMI.classify(18.5), equals(BMIClassification.normalRange.toString()));
    expect(BMI.classify(25), equals(BMIClassification.overweight.toString()));
    expect(BMI.classify(30), equals(BMIClassification.obeseClassI.toString()));
    expect(BMI.classify(35), equals(BMIClassification.obeseClassII.toString()));
    expect(BMI.classify(40), equals(BMIClassification.obeseClassIII.toString()));
  });

  test("Given a persons's weight and height, calculate it's BMI and get its classification", () {
    expect(BMI.classify(BMI.calculate(46, 1.70)), equals(BMIClassification.severeThinness.toString()));
    expect(BMI.classify(BMI.calculate(49, 1.70)), equals(BMIClassification.moderateThinness.toString()));
    expect(BMI.classify(BMI.calculate(52, 1.70)), equals(BMIClassification.mildThinness.toString()));
    expect(BMI.classify(BMI.calculate(60, 1.70)), equals(BMIClassification.normalRange.toString()));
    expect(BMI.classify(BMI.calculate(75, 1.70)), equals(BMIClassification.overweight.toString()));
    expect(BMI.classify(BMI.calculate(90, 1.70)), equals(BMIClassification.obeseClassI.toString()));
    expect(BMI.classify(BMI.calculate(105, 1.70)), equals(BMIClassification.obeseClassII.toString()));
    expect(BMI.classify(BMI.calculate(120, 1.70)), equals(BMIClassification.obeseClassIII.toString()));
  });
}
