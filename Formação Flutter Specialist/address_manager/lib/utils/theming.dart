import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const seedColor = Color(0XFF008000);

final _theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  ),
);

final theme = _theme.copyWith(
  textTheme: GoogleFonts.kanitTextTheme(_theme.textTheme),
);
