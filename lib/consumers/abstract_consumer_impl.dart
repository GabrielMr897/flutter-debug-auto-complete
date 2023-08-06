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
    // TODO(edufolly): Implement mock.
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
    // TODO(edufolly): Implement mock.
    return <T>[];
  }

  ///
  ///
  ///
  @override
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model,
  ) async => true;

  ///
  ///
  ///
  @override
  Future<bool> delete(
    BuildContext context,
    T model,
  ) async => true;
}
