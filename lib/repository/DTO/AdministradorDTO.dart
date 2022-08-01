import 'package:iptv/model/bin/Administrador.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../model/sqlite/SqlHelper.dart';
import '../../model/sqlite/utils/TabelaAdministrador.dart';
import '../interface/IAdministrador.dart';

class AdministradorDTO implements IAdministrador {
  
  static AdministradorDTO ?_instance; 
  AdministradorDTO._internal();

  static AdministradorDTO? get instance => _instance == null? AdministradorDTO._internal():_instance;

  @override
  Future insert(Administrador adm) async {
    Database dataBase = await SqlHelper.instance.db;
    //insere adm tbm e pega o retorno. se 0 ou null. já existe.
    int id = 0;
    try {
      id = await dataBase.insert(TabelaAdministrador.NOME_TABELA, adm.toMap());
      // print("ID ADM: "+valor.toString());
    } catch (ex) {
      print('Failed to insert: ' + ex.toString());//tratar np controller
    }
    return id;
  }
}
