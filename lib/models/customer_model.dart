import 'package:debug_auto_complete/consumers/price_table_consumer.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
class CustomerModel extends AbstractModel<int> {
  String name;
  String lastName;
  int age;
  String email;
  PriceTableModel? priceTable;

  ///
  ///
  ///
  CustomerModel({
    required this.name,
    required this.lastName,
    required this.age,
    required this.email,
  });

  ///
  ///
  ///
  CustomerModel.fromJson(super.map)
      : name = map['name'],
        lastName = map['lastName'],
        age = map['age'],
        email = map['email'],
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
    map['name'] = name;
    map['lastName'] = lastName;
    map['age'] = age;
    map['email'] = email;
    map['price_table'] = ModelUtils.toMapModel(priceTable);
    return map;
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toSave() {
    Map<String, dynamic> map = toMap();
    ModelUtils.toSaveMapId(map['price_table']);
    return map;
  }

  ///
  ///
  ///
  @override
  String toString() => name;
}
