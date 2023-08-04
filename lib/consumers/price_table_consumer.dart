import 'package:debug_auto_complete/consumers/abstract_consumer_impl.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';

///
///
///
class PriceTableConsumer extends AbstractConsumerImpl<PriceTableModel> {
  ///
  ///
  ///
  const PriceTableConsumer() : super(const <String>['price_table']);

  ///
  ///
  ///
  @override
  PriceTableModel fromJson(Map<String, dynamic> map) =>
      PriceTableModel.fromJson(map);
}
