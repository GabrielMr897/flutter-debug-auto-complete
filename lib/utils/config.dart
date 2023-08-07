import 'package:flutter/material.dart';
import 'package:folly_fields/folly_fields.dart';

///
///
///
class Config extends AbstractConfig {
  static final Config _singleton = Config._internal();

  ///
  ///
  ///
  factory Config() => _singleton;

  ///
  ///
  ///
  Config._internal();

  bool dark = false;
  Color alertColor = Colors.red;
  MaterialColor baseColor = Colors.amber;
  String name = 'Debug Auto Complete';
}
