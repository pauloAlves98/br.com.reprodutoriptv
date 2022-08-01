//@dart=2.9
import 'package:flutter/material.dart';
import 'package:iptv/view/pages/CadastroListaPage.dart';
import 'package:iptv/view/pages/CanaisPage.dart';
import 'package:iptv/view/pages/HomePage.dart';
import 'package:iptv/view/pages/ListaPage.dart';
import 'package:iptv/view/pages/Splash.dart';
import 'view/pages/SGBDPage.dart';
import 'view/pages/ExibirCanalPage.dart';

const String SGBDPAGE = "/SGBDPAGE";
const String HOMEPAGE = "/HOMEPAGE";
const String CADASTROLISTAPAGE = "/CADASTROLISTAPAGE";
const String SPLASHPAGE = "/SPLASH";
const String CANALPAGE = "/CANALPAGE";
const String EXIBIRCANALPAGE = "/ EXIBIRCANALPAGE";
const String LISTAPAGE = "/LISTAPAGE";

Map<String, WidgetBuilder> routes = {
  "/": (_) => Splash(),
  SGBDPAGE: (_) => SGBDPage(),
  HOMEPAGE: (_) => HomePage(),
  CADASTROLISTAPAGE: (_) => CadastroListaPage(),
  SPLASHPAGE: (_) => Splash(),
  CANALPAGE: (_) => CanaisPage(),
  EXIBIRCANALPAGE: (_) => ExibirCanalPage(),
  LISTAPAGE: (_) => ListaPage(),
};

void main() {
  runApp(
    MaterialApp(
      title: 'IPTV CANAIS V.1',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    ),
  );
}