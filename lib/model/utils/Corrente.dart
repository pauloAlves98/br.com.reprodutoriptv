//@dart=2.9
import 'package:iptv/model/bin/Canal.dart';
import 'package:iptv/model/bin/Categoria.dart';
import 'package:iptv/model/bin/Cliente.dart';
import 'package:iptv/model/bin/Lista.dart';

class Corrente{
  static Cliente clienteCorrente;
  static Canal canalCorrente;
  static List<Lista> listasCorrente;
  static List<Categoria> categoriasCorrente;
  static Lista listaCorrente;
}