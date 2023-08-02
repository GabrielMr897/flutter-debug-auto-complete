import 'package:debug_auto_complete/utils/config.dart';
import 'package:debug_auto_complete/views/lists/sales_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folly_fields/crud/abstract_route.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/config_utils.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FollyFields.start(Config());
  runApp(DebugAutoComplete());
}

///
///
///
class DebugAutoComplete extends StatelessWidget {
  ///
  ///
  ///
  DebugAutoComplete({super.key});

  ///
  ///
  ///
  Future<SharedPreferences> _loadingApp(BuildContext context) async {
    Config config = Config();

    ConfigUtils utils = ConfigUtils(context);

    await utils.loadFromAsset('config.json');

    int baseInt = utils.intOrDefault('baseColor', 0xFFFFA000);

    String server = utils.stringOrDefault('server', 'http://192.168.1.72:8081');

    if (server.endsWith('/')) {
      server = server.substring(0, server.length - 1);
    }

    config
      ..customer = utils.stringOrDefault('customer', 'bintech')
      ..name = utils.stringOrDefault('name', 'BinTech')
      ..dark = utils.boolOrDefault('dark', defaultValue: false)
      ..baseColor = FollyUtils.createMaterialColor(intColor: baseInt)!
      ..alertColor = Color(utils.intOrDefault('alertColor', 0xFFF44336))
      ..endpoint = '$server/api/v${Config().wsVersion}'
      ..download = '$server/download'
      ..logoPercent = utils.doubleOrDefault('logoPercent', 0.3)
      ..logoMin = utils.doubleOrDefault('logoMin', 250)
      ..logoMax = utils.doubleOrDefault('logoMax', 280);

    return SharedPreferences.getInstance();
  }

  ///
  ///
  ///
  final List<AbstractRoute> _routes = <AbstractRoute>[];

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: _loadingApp(context),
        builder: (
          BuildContext context,
          AsyncSnapshot<SharedPreferences> snapshot,
        ) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Config().name,
              theme: ThemeData(
                brightness: Config().dark ? Brightness.dark : Brightness.light,
                primarySwatch: Config().baseColor,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Config().baseColor,
                  selectionColor: Config().baseColor.withOpacity(0.4),
                  selectionHandleColor: Config().baseColor,
                ),
              ),
              home: SalesOrderList(),
              routes: <String, Widget Function(BuildContext)>{
                for (AbstractRoute route in _routes) route.path: (_) => route
              },
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                ...GlobalMaterialLocalizations.delegates,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const <Locale>[
                Locale('pt', 'BR'),
              ]);
        });
  }
}
