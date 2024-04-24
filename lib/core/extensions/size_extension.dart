import 'package:flutter/material.dart';

extension Size on BuildContext {
  // Width mediaquery
  double get w => MediaQuery.of(this).size.width;

  // height mediaquery
  double get h => MediaQuery.of(this).size.height;
}
