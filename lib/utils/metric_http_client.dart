import 'dart:convert';

import 'package:debug_auto_complete/utils/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
class MetricHttpClient extends BaseClient {
  final Client _inner;

  ///
  ///
  ///
  MetricHttpClient(this._inner);

  ///
  ///
  ///
  @override
  Future<StreamedResponse> send(BaseRequest request) async =>
      _inner.send(request);

  ///
  ///
  ///
  static Future<Map<String, String>> getHeaders(String unique) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    // if (Config().isDebug) print('${unique ?? ''} Token Up: $token');

    if (token.isNotEmpty) {
      headers['Token'] = token;
    }

    return headers;
  }

  ///
  ///
  ///
  static Uri getUri(
    List<String> paths,
    Map<String, String> qsParam,
  ) {
    List<String> path = <String>[
      Config().endpoint,
      ...paths,
    ];

    Uri uri = Uri.parse(path.join('/'));

    Map<String, String> params = <String, String>{
      ...qsParam,
      'platform': Config().platform,
    };

    return uri.replace(queryParameters: params);
  }

  static Uri getUriById(
    List<String> paths,
    Map<String, String> qsParam,
  ) {
    List<String> path = <String>[
      Config().endpoint,
      ...paths,
    ];

    Uri uri = Uri.parse(path.join('/'));

    Map<String, String> params = <String, String>{
      ...qsParam,
      'platform': Config().platform,
    };

    return uri.replace(queryParameters: params);
  }

  ///
  ///
  ///
  static int getTimeout(int? timeout) =>
      (timeout == null || timeout < 10) ? Config().smallTimeout : timeout;

  ///
  ///
  ///
  static Future<Map<String, dynamic>> doGet({
    required BuildContext context,
    required List<String> paths,
    Map<String, String> qsParam = const <String, String>{},
    int? timeout,
    bool returnLog = false,
  }) async {
    String unique = UniqueKey().toString();

    timeout = getTimeout(timeout);

    Uri uri = getUri(paths, qsParam);

    if (kDebugMode) {
      print('$unique GET: $uri');
    }

    MetricHttpClient client = MetricHttpClient(Client());

    Response response =
        await client.get(uri).timeout(Duration(milliseconds: timeout));

    client.close();

    return _process(context, response, unique, returnLog);
  }

  ///
  ///
  ///
  static Future<Map<String, dynamic>> doGetById(
      {required BuildContext context,
      required List<String> paths,
      Map<String, String> qsParam = const <String, String>{},
      int? timeout,
      bool returnLog = false,
      String? id}) async {
    String unique = UniqueKey().toString();

    timeout = getTimeout(timeout);

    List<String> newPathList = List.from(paths);
    if (id != null) {
      newPathList.add(id);
    }

    Uri uri = getUri(newPathList, qsParam);

    if (kDebugMode) {
      print('$unique GET: $uri');
    }

    MetricHttpClient client = MetricHttpClient(Client());

    Response response =
        await client.get(uri).timeout(Duration(milliseconds: timeout));

    client.close();

    return _process(context, response, unique, returnLog);
  }

  ///
  ///
  ///
  static Future<Map<String, dynamic>> doPost({
    required BuildContext context,
    required List<String> paths,
    required Map<String, dynamic> body,
    Map<String, String> qsParam = const <String, String>{},
    int? timeout,
    bool returnLog = false,
  }) async {
    String unique = UniqueKey().toString();

    timeout = getTimeout(timeout);

    Uri uri = getUri(paths, qsParam);

    Map<String, String> headers = await getHeaders(unique);

    if (kDebugMode) {
      print('$unique POST: $uri');
      if (returnLog) {
        print('$unique Body: ${json.encode(body)}');
      }
    }

    MetricHttpClient client = MetricHttpClient(Client());

    Response response = await client
        .post(
          uri,
          encoding: Encoding.getByName('utf-8'),
          body: json.encode(body),
          headers: headers,
        )
        .timeout(Duration(milliseconds: timeout));

    client.close();

    return _process(context, response, unique, returnLog);
  }

  ///
  ///
  ///
  static Future<Map<String, dynamic>> doPut({
    required BuildContext context,
    required List<String> paths,
    required Map<String, dynamic> body,
    Map<String, String> qsParam = const <String, String>{},
    int? timeout,
    bool returnLog = false,
  }) async {
    String unique = UniqueKey().toString();

    timeout = getTimeout(timeout);

    Uri uri = getUri(paths, qsParam);

    Map<String, String> headers = await getHeaders(unique);

    if (kDebugMode) {
      print('$unique PUT: $uri');
      if (returnLog) {
        print('$unique Body: ${json.encode(body)}');
      }
    }

    MetricHttpClient client = MetricHttpClient(Client());

    Response response = await client
        .put(
          uri,
          encoding: Encoding.getByName('utf-8'),
          body: json.encode(body),
          headers: headers,
        )
        .timeout(Duration(milliseconds: timeout));

    client.close();

    return _process(context, response, unique, returnLog);
  }

  ///
  ///
  ///
  static Future<Map<String, dynamic>> doDelete({
    required BuildContext context,
    required List<String> paths,
    required Object id,
    Map<String, String> qsParam = const <String, String>{},
    int? timeout,
    bool returnLog = false,
  }) async {
    String unique = UniqueKey().toString();

    timeout = getTimeout(timeout);

    Map<String, String> newQs = <String, String>{
      ...qsParam,
      'id': id.toString(),
    };

    Uri uri = getUri(paths, newQs);

    Map<String, String> headers = await getHeaders(unique);

    if (kDebugMode) {
      print('$unique DELETE: $uri - Id: $id');
    }

    MetricHttpClient client = MetricHttpClient(Client());

    Response response = await client
        .delete(uri, headers: headers)
        .timeout(Duration(milliseconds: timeout));

    client.close();

    return _process(context, response, unique, returnLog);
  }

  ///
  ///
  ///
  static Future<Map<String, dynamic>> _process(
    BuildContext context,
    Response response,
    String unique,
    bool returnLog,
  ) async {
    if (kDebugMode) {
      if (response.statusCode != 200 || returnLog) {
        print('$unique Status: ${response.statusCode}');
        if (returnLog) {
          debugPrint(response.body, wrapWidth: 1024);
        }
      }
    }
    Map<String, dynamic> data = json.decode(response.body);

    print(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> headers = response.headers;

    String token = 'Empty';
    if (headers.containsKey('token')) {
      token = headers['token']!;
      await prefs.setString('token', token);
    }

    // if (Config().isDebug) print('$unique Token Down: $token');

    if (<int>[401, 403, 405].contains(response.statusCode)) {
      await prefs.clear();
    }

    int status = data['status'];
    if ((status < 200 || status >= 300) && data.containsKey('message')) {
      throw MetricHttpException(data['message']);
    }

    return data;
  }
}

///
///
///
class MetricHttpException implements Exception {
  final String message;

  const MetricHttpException(this.message);

  @override
  String toString() => message;
}
