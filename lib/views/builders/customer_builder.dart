import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/customer_model.dart';

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
  Widget getLeading(_, CustomerModel model) => const FaIcon(
        FontAwesomeIcons.solidCircle,
        color: Colors.green,
      );

  ///
  ///
  ///
  @override
  Map<String, Color> listLegend(_) => const <String, Color>{
        'Liberado': Colors.green,
        'Bloqueado': Colors.red,
      };

  ///
  ///
  ///
  @override
  Widget getTitle(_, CustomerModel customer) => Text(customer.name);

  ///
  ///
  ///
  @override
  Widget getSubtitle(_, CustomerModel customer) => Text(customer.id.toString());
}
