import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';

///
///
///
class CustomerBuilder extends AbstractUIBuilder<CustomerModel> {
  ///
  ///
  ///
  const CustomerBuilder({
    super.labelPrefix,
    super.labelSuffix,
  });

  ///
  ///
  ///
  @override
  String single(_) => 'Cliente';

  ///
  ///
  ///
  @override
  String plural(_) => 'Clientes';

  ///
  ///
  ///
  @override
  Widget getTitle(_, CustomerModel customer) => Text(customer.name);

  ///
  ///
  ///
  @override
  Widget getSubtitle(_, CustomerModel customer) => Text(customer.lastName);
}
