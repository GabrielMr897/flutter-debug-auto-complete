import 'package:debug_auto_complete/consumers/sales_order_consumer.dart';
import 'package:debug_auto_complete/models/sales_order_model.dart';
import 'package:debug_auto_complete/views/builders/sales_order_builder.dart';
import 'package:debug_auto_complete/views/edits/controllers/sales_order_edit_controller.dart';
import 'package:debug_auto_complete/views/edits/sales_order_edit.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/crud/abstract_list.dart';

///
///
///
class SalesOrderList extends AbstractList<SalesOrderModel, SalesOrderBuilder,
    SalesOrderConsumer> {
  ///
  ///
  ///
  SalesOrderList({
    super.key,
    super.selection = false,
    super.multipleSelection = false,
    bool filter = false,
  }) : super(
          forceOffline: false,
          consumer: const SalesOrderConsumer(),
          uiBuilder: const SalesOrderBuilder(),
          qsParam: <String, String>{'filter': filter.toString()},
          onAdd: (
            BuildContext context,
            SalesOrderBuilder uiBuilder,
            SalesOrderConsumer consumer,
          ) async =>
              SalesOrderEdit(
            SalesOrderModel(),
            uiBuilder,
            // editController: SalesOrderEditController(),
            consumer,
            edit: true,
          ),
          onUpdate: (
            BuildContext context,
            SalesOrderModel model,
            SalesOrderBuilder uiBuilder,
            SalesOrderConsumer consumer,
            bool edit,
          ) async =>
              SalesOrderEdit(
            model,
            uiBuilder,
            // editController: SalesOrderEditController(),
            consumer,
            edit: edit,
          ),
          modelFunctions: <AbstractModelFunction<SalesOrderModel>>[
            SalesOrderEditFromSalesOrderList(),
          ],
        );
}
