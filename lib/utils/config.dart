import 'package:flutter/material.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:intl/intl.dart';

///
///
///
class Config extends AbstractConfig {
  static final Config _singleton = Config._internal();

  static final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm', 'pt_br');
  static final DateFormat onlyDate = DateFormat('dd/MM/yyyy', 'pt_br');

  ///
  ///
  ///
  static String formatMessage(String? msg) => msg != null ? '* $msg\n' : '';

  ///
  ///
  ///
  factory Config() => _singleton;

  ///
  ///
  ///
  Config._internal();

  ///
  ///
  ///
  int wsVersion = 1;
  String endpoint = '';
  String download = '';
  int smallTimeout = 30000;
  String customer = 'bintech';
  String name = 'Debug-auto-complete';
  bool dark = false;
  Color alertColor = Colors.red;
  MaterialColor baseColor = Colors.amber;
}
