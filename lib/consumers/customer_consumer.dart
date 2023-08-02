import 'package:debug_auto_complete/consumers/abstract_consumer_impl.dart';
import 'package:debug_auto_complete/models/customer_model.dart';

///
///
///
class CustomerConsumer extends AbstractConsumerImpl<CustomerModel> {
  ///
  ///
  ///
  const CustomerConsumer() : super(const <String>['customer']);

  ///
  ///
  ///
  @override
  CustomerModel fromJson(Map<String, dynamic> map) =>
      CustomerModel.fromJson(map);
}
