import 'package:debug_auto_complete/consumers/customer_consumer.dart';
import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
class SalesOrderModel extends AbstractModel<int> {
  CustomerModel? customer;

  ///
  ///
  ///
  SalesOrderModel();

  ///
  ///
  ///
  SalesOrderModel.toCopy(SalesOrderModel model) : customer = model.customer;

  ///
  ///
  ///
  SalesOrderModel.fromJson(super.map)
      : customer = ModelUtils.fromJsonModel(
          map['customer'],
          const CustomerConsumer(),
        ),
        super.fromJson();

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['customer'] = ModelUtils.toMapModel(customer);
    return map;
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toSave() {
    Map<String, dynamic> map = toMap();
    ModelUtils.toSaveMapId(map['customer']);
    return map;
  }
}
