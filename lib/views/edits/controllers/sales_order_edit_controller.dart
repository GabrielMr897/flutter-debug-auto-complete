import 'package:debug_auto_complete/consumers/customer_consumer.dart';
import 'package:debug_auto_complete/consumers/price_table_consumer.dart';
import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';
import 'package:debug_auto_complete/models/sales_order_model.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/model_editing_controller.dart';
import 'package:folly_fields/crud/abstract_edit_controller.dart';

///
///
///
class SalesOrderEditController extends AbstractEditController<SalesOrderModel> {
  final ModelEditingController<CustomerModel> customerController =
      ModelEditingController<CustomerModel>();

  final ModelEditingController<PriceTableModel> priceTableController =
      ModelEditingController<PriceTableModel>();

  ///
  ///
  ///
  @override
  Future<void> init(
    BuildContext context,
    SalesOrderModel model,
  ) async {
    customerController.model = model.customer;
    priceTableController.model = model.priceTable;

    // Load full price table.
    if (model.priceTable != null) {
      model.priceTable = await const PriceTableConsumer().getById(
        context,
        model.priceTable!,
      );
    }
  }

  ///
  ///
  ///
  Future<CustomerModel?> updateCustomer(
    BuildContext context,
    SalesOrderModel salesOrder,
    CustomerModel? customer,
  ) async {
    priceTableController.model = null;
    salesOrder.priceTable = null;

    if (customer != null) {
      // Load full customer.
      CustomerModel localCustomer =
          await const CustomerConsumer().getById(context, customer);

      customer = localCustomer;
      salesOrder.customer = localCustomer;

      // Update priceTable.
      if (localCustomer.priceTable != null) {
        await updatePriceTable(context, salesOrder, localCustomer.priceTable);
      }
    }

    return customer;
  }

  ///
  ///
  ///
  Future<PriceTableModel?> updatePriceTable(
    BuildContext context,
    SalesOrderModel salesOrder,
    PriceTableModel? priceTable,
  ) async {
    if (priceTable == null) {
      return null;
    }

    // If the selected price table is the same in sales order.
    if ((salesOrder.priceTable?.id ?? -1) == (priceTable.id ?? -2)) {
      return null;
    }

    // Load full price table.
    PriceTableModel fullPriceTable =
        await const PriceTableConsumer().getById(context, priceTable);

    salesOrder.priceTable = fullPriceTable;
    priceTableController.model = fullPriceTable;

    return fullPriceTable;
  }

  ///
  ///
  ///
  @override
  Future<void> dispose(BuildContext context) async {
    customerController.dispose();
    priceTableController.dispose();
  }
}
