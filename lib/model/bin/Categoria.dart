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
        if (aux.trimLeft().contains('group-title')) {
          RegExp regexgrupo = RegExp(r'group-title[\s]*[=][\s]*"[^"]*"'); //"^ SIGNIFICA QQ CARACTERE!"
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
  Future insert() async {
    Database dataBase = await SqlHelper().db;
    int valor = await dataBase.insert(TabelaCategoria.NOME_TABELA, toMap());
    print("Categoria $nome ID: " + valor.toString());
    return valor;
  }

  /// *Insere várias categorias de uma única vez. Utiliza inserção em Lotes.*
  static Future<List<dynamic>> insertAll(List<Categoria> categorias) async {
    Database dataBase = await SqlHelper().db;
    return await dataBase.transaction((txn) async {
      var batch = txn.batch();
      categorias.forEach((element) {
        batch.insert(TabelaCategoria.NOME_TABELA, element.toMap());
      });
      return await batch.commit();
    });
  }

  /// *Retorna todas as categorias com o nome destacado no parâmetro.*
  static Future<List<Categoria>> getAllPorNome(String nome, int idlista) async {
    //close no banco
    Database dataBase = await SqlHelper().db;
    List listMap =
        await dataBase.rawQuery(TabelaCategoria.getAllPorNome(nome, idlista));
    List<Categoria> categorias = [];
    for (Map m in listMap) {
      categorias.add(Categoria.fromMapSqLite(m));
    }
    return categorias;
  }
  /// *Retorna todas as categorias vinculadas a uma lista.*
  static Future<List<Categoria>> getAllLista(int idlista) async {
    //close no banco
    Database dataBase = await SqlHelper().db;
    List listMap =
        await dataBase.rawQuery(TabelaCategoria.getAllLista(idlista));
    List<Categoria> categorias = [];
    for (Map m in listMap) {
      categorias.add(Categoria.fromMapSqLite(m));
    }
    return categorias;
  }

  /// *Retorna o número de categorias vinculadas a uma lista.*
  static Future<int> getCountCategoriasPorLista(int idlista) {
    return Future<int>.delayed(Duration(seconds: 0), () async {
      Database dataBase = await SqlHelper().db;
      List listMap = await dataBase
          .rawQuery(TabelaCategoria.getCountCategoriasPorLista(idlista));
      int total = 0;
      String tbcat = TabelaCategoria.COL_ID;
      for (Map m in listMap) {
        //pra ler o map.
        //print(m.keys);
        total = m['count(DISTINCT $tbcat)'] != null
            ? m['count(DISTINCT $tbcat)']
            : 0;
        // pagamentos.add(Pagamento.fromMapSqLite(m));
      }
      print("Total de Categorias:" + total.toString());
      return total;
    });
  }
}
