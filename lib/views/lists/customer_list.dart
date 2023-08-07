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
  const CustomerList({
    super.key,
    super.selection = false,
    super.multipleSelection = false,
  }) : super(
          consumer: const CustomerConsumer(),
          uiBuilder: const CustomerBuilder(),
        );
}
