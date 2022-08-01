import 'package:iptv/model/bin/Categoria.dart';
import 'package:iptv/repository/interface/ICategoria.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../model/sqlite/SqlHelper.dart';
import '../../model/sqlite/utils/TabelaCategoria.dart';

class CategoriaDTO implements ICategoria {

  static CategoriaDTO? _instance;

  CategoriaDTO._internal();

  static CategoriaDTO? get instance =>
      _instance == null ? CategoriaDTO._internal() : _instance;

  @override
  /// *Retorna todas as categorias vinculadas a uma lista.*
  Future<List<Categoria>> getAllLista(int idLista) async {
    //close no banco
    List<Categoria> categorias = [];
    try {
      Database dataBase = await SqlHelper.instance.db;
      List listMap =
          await dataBase.rawQuery(TabelaCategoria.getAllLista(idLista));
      //trocar por map();     listMap.map((e) => Categoria.fromMapSqLite(e)).toList(); // Maneira mais rápida!
      for (Map m in listMap) {
        categorias.add(Categoria.fromMapSqLite(m));
      }
    } catch (e) {
      print("Exception CategoriaDTO - getAllLista(): ");
      print(e);
    }
    return categorias;
  }

  @override
  /// *Retorna todas as categorias com o nome destacado no parâmetro.*
  Future<List<Categoria>> getAllPorNome(String nome, int idlista) async {

    List<Categoria> categorias = [];

    try {
      Database dataBase = await SqlHelper.instance.db;
      List listMap =
          await dataBase.rawQuery(TabelaCategoria.getAllPorNome(nome, idlista));
      //listMap.map((e) => Categoria.fromMapSqLite(e)).toList(); // Maneira mais rápida!
      for (Map m in listMap) {
        categorias.add(Categoria.fromMapSqLite(m));
      }
    } catch (e) {
      print("Exception CategoriaDTO - getAllPorNome(): ");
      print(e);
    }
    return categorias;
  }

  @override
  /// *Retorna o número de categorias vinculadas a uma lista.*
  Future<int> getCountCategoriasPorLista(int idlista) async {
    int total = 0;
    try {
      Database dataBase = await SqlHelper.instance.db;
      List listMap = await dataBase
          .rawQuery(TabelaCategoria.getCountCategoriasPorLista(idlista));
      String tbCat = TabelaCategoria.COL_ID;

      for (Map m in listMap) {
        //print(m.keys);
        total = m['count(DISTINCT $tbCat)'] != null
            ? m['count(DISTINCT $tbCat)']
            : 0;
      }
      print("Total de Categorias:" + total.toString());
    } catch (e) {
      print("Exception CategoriaDTO - getCountCategoriasPorLista(): ");
      print(e);
    }

    return total;
  }

  @override
  Future insert(Categoria categoria) async {
    Database dataBase = await SqlHelper.instance.db;
    int id = 0;
    try {
      id =
          await dataBase.insert(TabelaCategoria.NOME_TABELA, categoria.toMap());
      String nome = categoria.nome;
      print("Categoria $nome ID: " + id.toString());
    } catch (e) {
      print("Exception CategoriaDTO - insert(): ");
      print(e);
    }
    return id;
  }

  @override
  /// *Insere várias categorias de uma única vez. Utiliza inserção em Lotes.*
  Future<List<dynamic>> insertAll(List<Categoria> categorias) async {
    Database dataBase = await SqlHelper.instance.db;
    return await dataBase.transaction((txn) async {
      var batch = txn.batch();
      categorias.forEach((element) {
        batch.insert(TabelaCategoria.NOME_TABELA, element.toMap());
      });
      return await batch.commit();
    });
  }
}
