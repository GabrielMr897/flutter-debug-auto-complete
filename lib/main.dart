import 'package:debug_auto_complete/home.dart';
import 'package:debug_auto_complete/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FollyFields.start(Config());
  runApp(const DebugAutoComplete());
}

///
///
///
class DebugAutoComplete extends StatelessWidget {
  ///
  ///
  ///
  const DebugAutoComplete({super.key});

  ///
  ///
  ///
  Future<SharedPreferences> _loadingApp(BuildContext context) async {
    return SharedPreferences.getInstance();
  }

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
            home: const HomePage(),
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
