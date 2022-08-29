import 'package:iptv/model/bin/Canal.dart';
import '../interface/ICanal.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../model/sqlite/SqlHelper.dart';
import '../../model/sqlite/utils/TabelaCanal.dart';

class CanalDTO implements ICanal {
  static CanalDTO? _instance;

  CanalDTO._internal();
  static CanalDTO? get instance =>
      _instance == null ? CanalDTO._internal() : _instance;

  @override

  /// *Retorna todos os canais vinculados a uma categoria.*
  Future<List<Canal>> getAllCategoria(int? idcat) async {
    Database dataBase = await SqlHelper.instance.db;
    List listMap = await dataBase.rawQuery(TabelaCanal.getAllCategoria(idcat!));

    print("ID de busca categoria: " + idcat.toString());
    List<Canal> canais = [];
    // List<Canal> categorias2 = [];
    // categorias2 = listMap.map((e) => Canal.fromMapSqLite(e)).toList(); // Maneira mais rápida!
    for (Map m in listMap) {
      canais.add(Canal.fromMapSqLite(m));
    }
    return canais;
  }

  @override

  /// *Retorna o número de canais vinculados a uma lista.*
  Future<int> getCountCanaisPorLista(int idlista) {
    return Future<int>.delayed(Duration(seconds: 0), () async {
      //Pode tirar esse deleyed!

      Database dataBase = await SqlHelper.instance.db;
      List listMap =
          await dataBase.rawQuery(TabelaCanal.getCountCanaisPorLista(idlista));

      int total = 0;
      // print("Contando Canais em Canal.dart L: 145");
      for (Map m in listMap) {
        //pq retorna map!
        //print(m.keys);
        total = m['count(id)'] != null ? m['count(id)'] : 0;
      }
      print("Total de Canais em Canal.dart L: 151:" + total.toString());
      return total;
    });
  }

  @override

  /// *Insere um canal.*
  Future insert(Canal canal) async {
    Database dataBase = await SqlHelper.instance.db;
    int id = 0;
    try {
      id = await dataBase.insert(TabelaCanal.NOME_TABELA, canal.toMap());
    } catch (e) {
      print("Erorr  insert CanalDTO:" + e.toString());
    }
    return id;
    //print("Canal $nome ID: " + valor.toString());
    //print("Link video");
    //print(linkVideo);
  }

  @override
  Future<List<Canal>> getAllLista(int? idList) async {
    // TODO: implement getAllLista
    Database dataBase = await SqlHelper.instance.db;
    List listMap = await dataBase.rawQuery(TabelaCanal.getAllLista(idList!));

    print("ID de busca categoria: " + idList.toString());
    List<Canal> canais = [];
    // List<Canal> categorias2 = [];
    // categorias2 = listMap.map((e) => Canal.fromMapSqLite(e)).toList(); // Maneira mais rápida!
    for (Map m in listMap) {
      canais.add(Canal.fromMapSqLite(m));
    }
    return canais;
  }

  @override
  Future<List<Canal>> getCanaisPorParametro(int idLista, String param) async {
    // TODO: implement getAllLista
    Database dataBase = await SqlHelper.instance.db;
    List listMap = await dataBase.rawQuery(TabelaCanal.getCanaisPorParametro(idLista, param));
    // print("ID de busca categoria: " + idList.toString());
    List<Canal> canais = [];
    // List<Canal> categorias2 = [];
    canais = listMap.map((e) => Canal.fromMapSqLite(e)).toList(); // Maneira mais rápida!
    // for (Map m in listMap) {
    //   canais.add(Canal.fromMapSqLite(m));
    // }
    return canais;
  }
}
