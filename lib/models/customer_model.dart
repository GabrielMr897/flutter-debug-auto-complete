import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/model_utils.dart';

class CustomerModel extends AbstractModel<int> {
  String name;
  String lastName;
  int age;
  String email;

  CustomerModel(
      {required this.name,
      required this.lastName,
      required this.age,
      required this.email});

  CustomerModel.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        lastName = map['lastName'],
        age = map['age'],
        email = map['email'],
        super.fromJson(map);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['name'] = name;
    map['lastName'] = lastName;
    map['age'] = age;
    map['email'] = email;
    return map;
  }

  @override
  Map<String, dynamic> toSave() {
    Map<String, dynamic> map = toMap();
    ModelUtils.toSaveMapId(map);
    return map;
  }
}
