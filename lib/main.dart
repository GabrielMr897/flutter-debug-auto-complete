import 'package:debug_auto_complete/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folly_fields/crud/abstract_route.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/config_utils.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Passo 2: Classe mock para representar os dados
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}

class MockApiService {
  List<User> getUsers() {
    return [
      User(id: 1, name: 'User 1', email: 'user1@example.com'),
      User(id: 2, name: 'User 2', email: 'user2@example.com'),
    ];
  }
}

Future<SharedPreferences> _loadingApp(BuildContext context) async {
  Config config = Config();

  MockApiService mockApi = MockApiService();
  List<User> mockUsers = mockApi.getUsers();
  config.customer = 'bintech';
  config.name = 'BinTech';
  config.baseColor = Colors.orange;
  config.alertColor = Colors.red;

  return SharedPreferences.getInstance();
}

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
        if (snapshot.hasData) {
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
            routes: <String, Widget Function(BuildContext)>{
              for (AbstractRoute route in _routes) route.path: (_) => route
            },
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              ...GlobalMaterialLocalizations.delegates,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale('pt', 'BR'),
            ],
          );
        }

        if (snapshot.hasError) {
          return ColoredBox(
            color: Colors.red,
            child: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        return const ColoredBox(
          color: Colors.transparent,
        );
      },
    );
  }
}
