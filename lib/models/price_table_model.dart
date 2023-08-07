import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class PriceTableModel extends AbstractModel<int> {
  String code = '';
  String description = '';

  ///
  ///
  ///
  PriceTableModel();

  ///
  ///
  ///
  PriceTableModel.fromJson(super.map)
      : code = map['code'] ?? '',
        description = map['description'] ?? '',
        super.fromJson();

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['code'] = code;
    map['description'] = description;
    return map;
  }

  ///
  ///
  ///
  @override
  String toString() => '$code - $description';
}
