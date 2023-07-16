import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final cepMask = MaskTextInputFormatter(
  mask: '#####-###',
  filter: {
    "#": RegExp(r'[0-9]')
  },
  type: MaskAutoCompletionType.lazy,
);

final textMask = FilteringTextInputFormatter.allow(RegExp('[ a-zA-Z]'));
