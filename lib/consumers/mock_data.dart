import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';

///
///
///
class MockData {
  ///
  ///
  ///
  static PriceTableModel priceTable1 = PriceTableModel()
    ..id = 1
    ..code = 'Tabela 1'
    ..description = 'Tabela 1';

  ///
  ///
  ///
  static PriceTableModel priceTable2 = PriceTableModel()
    ..id = 2
    ..code = 'Tabela 2'
    ..description = 'Tabela 2';

  ///
  ///
  ///
  static List<PriceTableModel> priceTables = <PriceTableModel>[
    priceTable1,
    priceTable2,
  ];

  ///
  ///
  ///
  static CustomerModel customer1 = CustomerModel()
    ..id = 1
    ..name = 'Cliente 1'
    ..lastName = 'Sobrenome 1'
    ..priceTable = priceTable1;

  ///
  ///
  ///
  static CustomerModel customer2 = CustomerModel()
    ..id = 2
    ..name = 'Cliente 2'
    ..lastName = 'Sobrenome 2'
    ..priceTable = priceTable2;

  ///
  ///
  ///
  static List<CustomerModel> customers = <CustomerModel>[
    customer1,
    customer2,
  ];
}
