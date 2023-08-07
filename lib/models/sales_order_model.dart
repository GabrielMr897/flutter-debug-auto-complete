import 'package:debug_auto_complete/consumers/customer_consumer.dart';
import 'package:debug_auto_complete/consumers/price_table_consumer.dart';
import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
class SalesOrderModel extends AbstractModel<int> {
  CustomerModel? customer;
  PriceTableModel? priceTable;

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
        priceTable = ModelUtils.fromJsonModel(
          map['price_table'],
          const PriceTableConsumer(),
        ),
        super.fromJson();

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['customer'] = ModelUtils.toMapModel(customer);
    map['price_table'] = ModelUtils.toMapModel(priceTable);
    return map;
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toSave() {
    Map<String, dynamic> map = toMap();
    ModelUtils.toSaveMapId(map['customer']);
    ModelUtils.toSaveMapId(map['price_table']);
    return map;
  }

  ///
  ///
  ///
  @override
  String toString() => '$id';
}
