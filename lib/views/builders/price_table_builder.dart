import 'package:debug_auto_complete/models/price_table_model.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';

///
///
///
class PriceTableBuilder extends AbstractUIBuilder<PriceTableModel> {
  ///
  ///
  ///
  const PriceTableBuilder({
    super.labelPrefix,
    super.labelSuffix,
  });

  ///
  ///
  ///
  @override
  String single(_) => 'Tabela de Preço';

  ///
  ///
  ///
  @override
  String plural(_) => 'Tabelas de Preço';

  ///
  ///
  ///
  @override
  Widget getTitle(_, PriceTableModel customer) => Text(customer.code);

  ///
  ///
  ///
  @override
  Widget getSubtitle(_, PriceTableModel customer) => Text(customer.description);
}
