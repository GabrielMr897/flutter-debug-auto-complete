import 'package:debug_auto_complete/consumers/customer_consumer.dart';
import 'package:debug_auto_complete/consumers/price_table_consumer.dart';
import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';
import 'package:debug_auto_complete/models/sales_order_model.dart';
import 'package:debug_auto_complete/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/date_editing_controller.dart';
import 'package:folly_fields/controllers/model_editing_controller.dart';
import 'package:folly_fields/controllers/new_decimal_editing_controller.dart';
import 'package:folly_fields/crud/abstract_edit_controller.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';

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
    if (customer != null) {
      String message = '';
      bool isOK = false;

      salesOrder.priceTable = null;
      priceTableController.model = null;

      // Load full customer.
      salesOrder.customer =
          await const CustomerConsumer().getById(context, customer);

      if (message.isNotEmpty) {
        // ignore: use_build_context_synchronously
        await FollyDialogs.dialogMessage(context: context, message: message);
      }

      // Update priceTable.
      if (salesOrder.customer!.priceTable != null) {
        // ignore: use_build_context_synchronously
        String? priceTableMessage = await updatePriceTable(
          context,
          salesOrder,
          salesOrder.customer!.priceTable,
        );

        if (priceTableMessage != null) {
          message += priceTableMessage;
        }
      }
    }

    return customer;
  }

  ///
  ///
  ///
  Future<String?> updatePriceTable(BuildContext context,
      SalesOrderModel salesOrder, PriceTableModel? priceTable) async {
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

    priceTableController.model = fullPriceTable;
    salesOrder.priceTable = fullPriceTable;

    return null;
  }

  ///
  ///
  ///
  @override
  Future<void> dispose(BuildContext context) async {}
}
