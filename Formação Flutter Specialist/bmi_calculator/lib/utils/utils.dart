import 'package:bmi_calculator/bmi/bmi_classification.dart';
import 'package:bmi_calculator/utils/extensions.dart';
import 'package:flutter/material.dart';

String getTerminalColoredTextByClassification(String classification) {
  return switch (classification) {
    _ when classification == BMIClassification.severeThinness.toString() => classification.asDanger,
    _ when classification == BMIClassification.moderateThinness.toString() => classification.asAlert,
    _ when classification == BMIClassification.mildThinness.toString() => classification.asWarning,
    _ when classification == BMIClassification.normalRange.toString() => classification.asNeutral,
    _ when classification == BMIClassification.overweight.toString() => classification.asWarning,
    _ when classification == BMIClassification.obeseClassI.toString() => classification.asAlert,
    _ when classification == BMIClassification.obeseClassII.toString() => classification.asAlert,
    _ when classification == BMIClassification.obeseClassIII.toString() => classification.asDanger,
    _ => classification
  };
}

Color getColorByClassification(String classification) {
  return switch (classification) {
    _ when classification == BMIClassification.severeThinness.toString() => Color(0XFFFF5555),
    _ when classification == BMIClassification.moderateThinness.toString() => Color(0XFFFFB86C),
    _ when classification == BMIClassification.mildThinness.toString() => Color(0XFFF1FA8C),
    _ when classification == BMIClassification.normalRange.toString() => Color(0XFF50fa7b),
    _ when classification == BMIClassification.overweight.toString() => Color(0XFFF1FA8C),
    _ when classification == BMIClassification.obeseClassI.toString() => Color(0XFFFFB86C),
    _ when classification == BMIClassification.obeseClassII.toString() => Color(0XFFFFB86C),
    _ when classification == BMIClassification.obeseClassIII.toString() => Color(0XFFFF5555),
    _ => Colors.white
  };
}

void printAllColors() {
  for (var i = 0; i < 256; ++i) {
    print("\x1b[38;5;${i}m$i\x1b[0m");
  }
  for (var i = 0; i < 256; ++i) {
    print("\x1b[48;5;${i}m$i\x1b[0m");
  }
}
