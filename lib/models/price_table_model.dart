import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/model_utils.dart';

class PriceTableModel extends AbstractModel<int> {
  String code;
  String description;

  PriceTableModel({required this.code, required this.description});

  PriceTableModel.fromJson(Map<String, dynamic> map)
      : code = map['code'],
        description = map['description'],
        super.fromJson(map);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['code'] = code;
    map['description'] = description;
    return map;
  }

  @override
  Map<String, dynamic> toSave() {
    Map<String, dynamic> map = toMap();
    return map;
  }

  @override
  String toString() {
    return code;
  }
}
