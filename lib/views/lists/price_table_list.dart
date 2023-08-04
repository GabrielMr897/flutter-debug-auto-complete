import 'package:debug_auto_complete/consumers/price_table_consumer.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';
import 'package:debug_auto_complete/views/builders/price_table_builder.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/crud/abstract_list.dart';

///
///
///
class PriceTableList extends AbstractList<PriceTableModel, PriceTableBuilder,
    PriceTableConsumer> {
  ///
  ///
  ///
  PriceTableList({
    super.key,
    super.selection = false,
    super.multipleSelection = false,
    String labelPrefix = '',
  }) : super(
          forceOffline: false,
          consumer: const PriceTableConsumer(),
          uiBuilder: PriceTableBuilder(labelPrefix: labelPrefix),
        );
}
