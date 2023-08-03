import 'package:debug_auto_complete/consumers/customer_consumer.dart';
import 'package:debug_auto_complete/models/customer_model.dart';
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

  final TextEditingController emailCustomerController = TextEditingController();

  ///
  ///
  ///
  @override
  Future<void> init(
    BuildContext context,
    SalesOrderModel model,
  ) async {
    customerController.model = model.customer;
    emailCustomerController.text = model.customer!.email;
    // Load full price table.
    if (model.customer != null) {
      model.customer = await const CustomerConsumer().getById(
        context,
        model.customer!,
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

      // Load full customer.
      salesOrder.customer =
          await const CustomerConsumer().getById(context, customer);

      customerController.model = salesOrder.customer;
      emailCustomerController.text = salesOrder.customer!.email;

      if (message.isNotEmpty) {
        // ignore: use_build_context_synchronously
        await FollyDialogs.dialogMessage(context: context, message: message);
      }
    }

    return customer;
  }

  ///
  ///
  ///
  @override
  Future<void> dispose(BuildContext context) async {}
}
