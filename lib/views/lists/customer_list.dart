import 'package:debug_auto_complete/consumers/customer_consumer.dart';
import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:debug_auto_complete/views/builders/customer_builder.dart';
import 'package:folly_fields/crud/abstract_list.dart';

///
///
///
class CustomerList
    extends AbstractList<CustomerModel, CustomerBuilder, CustomerConsumer> {
  ///
  ///
  ///
  CustomerList({
    super.key,
    super.selection = false,
    super.multipleSelection = false,
    String labelPrefix = '',
  }) : super(
            forceOffline: false,
            consumer: const CustomerConsumer(),
            uiBuilder: CustomerBuilder(labelPrefix: labelPrefix));
}
