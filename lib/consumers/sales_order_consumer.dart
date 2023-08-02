import 'package:debug_auto_complete/consumers/abstract_consumer_impl.dart';
import 'package:debug_auto_complete/models/sales_order_model.dart';
import 'package:debug_auto_complete/utils/metric_http_client.dart';
import 'package:flutter/material.dart';

///
///
///
class SalesOrderConsumer extends AbstractConsumerImpl<SalesOrderModel> {
  ///
  ///
  ///
  const SalesOrderConsumer() : super(const <String>['salesorder']);

  ///
  ///
  ///
  @override
  SalesOrderModel fromJson(Map<String, dynamic> map) =>
      SalesOrderModel.fromJson(map);
}
