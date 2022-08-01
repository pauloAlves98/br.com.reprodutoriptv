import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/repository/interface/ILista.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/sqlite/SqlHelper.dart';
import '../../model/sqlite/utils/Comum.dart';
import '../../model/sqlite/utils/TabelaCanal.dart';
import '../../model/sqlite/utils/TabelaCategoria.dart';
import '../../model/sqlite/utils/TabelaLista.dart';

class ListaDTO implements ILista {
  static ListaDTO? _instance;

  ListaDTO._internal();
  static ListaDTO? get instance =>
      _instance == null ? ListaDTO._internal() : _instance;

  @override
  /// *Deleta todas as categorias e canais vinculados a uma lista, incluindo a lista!*
  Future<List<dynamic>> deleteCascade(int idList) async {
    Database dataBase = await SqlHelper.instance.db;
    
    return await dataBase.transaction((txn) async {
      var batch = txn.batch();
      batch.rawDelete(TabelaCanal.removeAllLista(idList));
      batch.rawDelete(TabelaCategoria.removeAllLista(idList));
      batch.rawDelete(Comum.removeId(idList, TabelaLista.NOME_TABELA));
      return await batch.commit();
    });
  }

  @override
  /// *Retorna todas as listas vinculadas a um cliente.*
  Future<List<Lista>> getAllCliente(int id) {
    return Future<List<Lista>>.delayed(Duration(seconds: 0), () async {
      Database dataBase = await SqlHelper.instance.db;
      List listMap = await dataBase.rawQuery(TabelaLista.getAllCliente(id));
      List<Lista> listas = [];
      for (Map m in listMap) {
        listas.add(Lista.fromMapSqLite(m));
        //print(Lista.fromMapSqLite(m).nome);
        //print(Lista.fromMapSqLite(m).id.toString());
      }
      return listas;
    });
  }

  @override
  Future insert(Lista lista) async {
    Database dataBase = await SqlHelper.instance.db;
    int id = await dataBase.insert(TabelaLista.NOME_TABELA, lista.toMap());
    String nome = lista.nome;
    print("Lista $nome ID: " + id.toString());
    return id;
  }
}
