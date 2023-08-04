import 'package:debug_auto_complete/utils/config.dart';
import 'package:debug_auto_complete/utils/metric_http_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';

///
///
///
abstract class AbstractConsumerImpl<T extends AbstractModel<Object>>
    extends AbstractConsumer<T> {
  ///
  ///
  ///
  // TODO(edufolly): Check this hint.
  // ignore: use_super_parameters
  const AbstractConsumerImpl(
    List<String> routeName, {
    bool returnLog = false,
  }) : super(routeName, returnLog: returnLog);

  ///
  ///
  ///
  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  ) async {
    paths = paths.isEmpty ? routeName : paths;

    String path = '/api/v${Config().wsVersion}/${paths.join('/')}';

    if (kDebugMode) {
      print('Permission: $path');
    }

    // ignore: always_specify_types
    return ConsumerPermission.fromJson(const {
      'message': 'OK',
      'entity': {
        'menu': true,
        'view': true,
        'insert': true,
        'update': true,
        'delete': true,
        'iconName': 'cartArrowDown',
        'name': 'Pedidos de Venda'
      },
      'status': 200
    });
  }

  ///
  ///
  ///
  @override
  Future<T> getById(
    BuildContext context,
    T model,
  ) async {
    Map<String, dynamic> response = await MetricHttpClient.doGetById(
        context: context,
        paths: routeName,
        returnLog: returnLog,
        id: model.id.toString());

    dynamic list = response['entity'] ?? <dynamic>[];

    print(list);

    return fromJson(AbstractModel.fromMultiMap(list));
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
    print('antes do doget');

    Map<String, dynamic> response = await MetricHttpClient.doGet(
      context: context,
      paths: routeName,
      qsParam: qsParam,
      returnLog: returnLog,
    );

    print(response);

    List<dynamic> list = response['entity'] ?? <dynamic>[];

    return list
        .map<T>((dynamic item) => fromJson(AbstractModel.fromMultiMap(item)))
        .toList();
  }

  ///
  ///
  ///
  @override
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model,
  ) async {
    Map<String, dynamic> response;

    if (model.id == null) {
      response = await MetricHttpClient.doPost(
        context: context,
        paths: routeName,
        body: model.toSave(),
        returnLog: returnLog,
      );
    } else {
      response = await MetricHttpClient.doPut(
          context: context,
          paths: routeName,
          body: model.toSave(),
          returnLog: returnLog,
          id: model.id.toString());
    }

    int status = response['status'];
    if (status >= 200 && status < 300) {
      return true;
    } else {
      // ignore: use_build_context_synchronously
      await FollyDialogs.dialogMessage(
        context: context,
        title: 'Erro',
        message: response['message'],
      );
      return false;
    }
  }

  ///
  ///
  ///
  @override
  Future<bool> delete(
    BuildContext context,
    T model,
  ) async {
    Map<String, dynamic> response = await MetricHttpClient.doDelete(
      context: context,
      paths: routeName,
      id: model.id!,
      returnLog: returnLog,
    );

    int status = response['status'];
    if (status >= 200 && status < 300) {
      return true;
    } else {
      // ignore: use_build_context_synchronously
      await FollyDialogs.dialogMessage(
        context: context,
        title: 'Erro',
        message: response['message'],
      );
      return false;
    }
  }
}
