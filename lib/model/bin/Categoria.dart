// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/model/sqlite/SqlHelper.dart';
import 'package:iptv/model/sqlite/utils/TabelaCategoria.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

class Categoria {
  int? _id;
  String? _nome;
  int? _idlista;
  String? _status = "ATIVA";

  Categoria();
  // ignore: non_constant_identifier_names
  Categoria.simples(String nome, int id_lista) {
    this._nome = nome;
    this._idlista = id_lista;
  }

  static const String SEM_CATEGORIA = "SEM_CATEGORIA";
  //metodos de conversão
  Categoria.fromMapSqLite(Map map) {
    _id = map[TabelaCategoria.COL_ID];
    _nome = map[TabelaCategoria.COL_NOME];
    _idlista = map[TabelaCategoria.COL_LISTA];
    _status = map[TabelaCategoria.COL_STATUS];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      TabelaCategoria.COL_ID: _id,
      TabelaCategoria.COL_NOME: _nome,
      TabelaCategoria.COL_LISTA: _idlista,
      TabelaCategoria.COL_STATUS: _status
    };
    return map;
  }

  // GETTERS E SETTERS
  int? get id => this._id;
  set id(int? value) => this._id = value;
  //
  get nome => this._nome;
  set nome(value) => this._nome = value;

  //extrair categorias
  static Future<List<Categoria>?> carregaCategoria(
      List<dynamic> lista, int idlista) async {
    //lista vinda do metodo carrega lista de Lista.
    //lançar exceçoe personalizadas
    List<String> auxCategorias = [];
    List<Categoria> categorias = [];
    try {
      lista.forEach((line) {
        String aux = line[0].toString();
        if (aux.trimLeft().contains('group-title')) {//contem uma categoria
          RegExp regexgrupo = RegExp(r'group-title[\s]*[=][\s]*"[^"]*"'); //pega tudo e para em uma aspas duplas - "^ SIGNIFICA QQ CARACTERE!"
          String grupo = regexgrupo.stringMatch(aux).toString();
          grupo = grupo.replaceAll(RegExp(r'group-title[\s]*[=][\s]*'), '');
          grupo = grupo.replaceAll('"', "").trimLeft();
          grupo = grupo.length <= 0 ? SEM_CATEGORIA : grupo;
          if (!auxCategorias.contains(grupo)) {
            //SE A CATEGORIA NAO EXISTIR NA LISTA
            auxCategorias.add(grupo);
            categorias.add(new Categoria.simples(grupo, idlista));
          }
        } else {
          if (!auxCategorias.contains(SEM_CATEGORIA)) {
            //SE A CATEGORIA NAO EXISTIR NA LISTA
            auxCategorias.add(SEM_CATEGORIA);
            categorias.add(new Categoria.simples(SEM_CATEGORIA, idlista));
          }
        }
      });
    } catch (e) {
      throw new Exception(//criar exception personalisadas
          "Erro ao ler arquivo classe categoria : " + e.toString());
    }

    return categorias;
  }

  //metodos de acesso ao bd.
  



}
