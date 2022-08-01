import 'package:iptv/model/bin/Cliente.dart';
import 'package:iptv/repository/interface/ICliente.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/sqlite/SqlHelper.dart';
import '../../model/sqlite/utils/Comum.dart';
import '../../model/sqlite/utils/TabelaCliente.dart';


//Colocar padrao agr e ver aula repository.

class ClienteDTO implements ICliente {

  static ClienteDTO ?_instance; 

  ClienteDTO._internal();
  static ClienteDTO? get instance => _instance == null? ClienteDTO._internal():_instance;

  @override
  /// *Retorna todos os clientes.*
  Future<List<Cliente>> getAll() {

    return Future<List<Cliente>>.delayed(Duration(seconds: 1), () async {
      Database dataBase = await SqlHelper.instance.db;
      List listMap =
          await dataBase.rawQuery(Comum.getAll(TabelaCliente.NOME_TABELA));
      List<Cliente> listas = [];
      for (Map m in listMap) {
        listas.add(Cliente.fromMapSqLite(m));
        // print(Cliente.fromMapSqLite(m).nome);
        // print(Cliente.fromMapSqLite(m).id.toString());
      }
      return listas;
    });
  }

  @override
  Future insert(Cliente cliente) async {
    Database dataBase = await SqlHelper.instance.db;
    //insere adm tbm e pega o retorno. se 0 ou null. já existe.
    int valor = 0;
    try {
      valor = await dataBase.insert(TabelaCliente.NOME_TABELA, cliente.toMap());
      print("ID Cliente: " + valor.toString());
    } catch (ex) {
      print('Failed to insert: ' + ex.toString());
      throw Exception("Class Cliente L:79 " + ex.toString());
    }
    return valor;
  }
}
