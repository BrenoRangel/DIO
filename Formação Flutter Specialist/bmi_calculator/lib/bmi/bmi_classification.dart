enum BMIClassification {
  severeThinness('Severe Thinness'),
  moderateThinness('Moderate Thinness'),
  mildThinness('Mild Thinness'),
  normalRange('Normal Range'),
  overweight('Overweight'),
  obeseClassI('Obese Class I'),
  obeseClassII('Obese Class II (Severe)'),
  obeseClassIII('Obese Class III (Morbid)');

  const BMIClassification(this._value);

  final String _value;

  @override
  toString() => _value;
}
