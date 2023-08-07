import 'package:debug_auto_complete/models/sales_order_model.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';

///
///
///
class SalesOrderBuilder extends AbstractUIBuilder<SalesOrderModel> {
  ///
  ///
  ///
  const SalesOrderBuilder({
    super.labelPrefix,
    super.labelSuffix,
  });

  ///
  ///
  ///
  @override
  String single(_) => 'Pedido de Venda';

  ///
  ///
  ///
  @override
  String plural(_) => 'Pedidos de Venda';

  ///
  ///
  ///
  @override
  Widget getTitle(_, SalesOrderModel salesOrder) =>
      Text('Pedido nº ${salesOrder.id}');

  ///
  ///
  ///
  @override
  Widget getSubtitle(_, SalesOrderModel salesOrder) =>
      Text(salesOrder.customer?.name ?? 'Sem cliente');
}
