import 'package:debug_auto_complete/consumers/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
abstract class AbstractConsumerImpl<T extends AbstractModel<Object>>
    extends AbstractConsumer<T> {
  ///
  ///
  ///
  const AbstractConsumerImpl(
    super.routeName, {
    super.returnLog,
  });

  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  ) async =>
      const ConsumerPermission(
        menu: true,
        view: true,
        insert: true,
        update: true,
        delete: true,
        name: 'Mock',
      );

  ///
  ///
  ///
  @override
  Future<T> getById(
    BuildContext context,
    T model,
  ) async {
    switch (routeName.first) {
      case 'price_table':
        switch (model.id) {
          case 1:
            return MockData.priceTable1 as T;
          case 2:
            return MockData.priceTable2 as T;
        }
        break;
      case 'customer':
        switch (model.id) {
          case 1:
            return MockData.customer1 as T;
          case 2:
            return MockData.customer2 as T;
        }
        break;
    }

    return model;
  }

  ///
  ///
  ///
  @override
  Future<List<T>> list(
    BuildContext context,
    Map<String, String> qsParam, {
    required bool forceOffline,
  }) async {
    if ((qsParam['f'] ?? '0') == '0') {
      switch (routeName.first) {
        case 'price_table':
          return MockData.priceTables as List<T>;
        case 'customer':
          return MockData.customers as List<T>;
      }
    }

    return <T>[];
  }

  ///
  ///
  ///
  @override
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model,
  ) async =>
      true;

  ///
  ///
  ///
  @override
  Future<bool> delete(
    BuildContext context,
    T model,
  ) async =>
      true;
}
