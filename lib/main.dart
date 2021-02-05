import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/ui/screen/home/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran/ui/screen/quran/suras_list_screen.dart';
import 'package:quran/ui/screen/read/read_quran_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        locale: Locale('ar', 'AE'),
        theme: ThemeData(
          fontFamily: 'Cairo',
          primaryColor: Color(kLightPrimaryColor),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          // When navigating to the "/quran" route, build the ReadQuranScreen widget.
          '/suras_list': (context) => SurasListScreen(),
          '/read_quran': (context) => ReadQuranScreen(
                surasNumber: 1,
              )
        },
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
