bool isValidName(String name) {
  final nameRegExp = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
  return nameRegExp.hasMatch(name);
}
