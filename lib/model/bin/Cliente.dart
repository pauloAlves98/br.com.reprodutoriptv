import 'package:iptv/model/bin/Usuario.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/model/sqlite/SqlHelper.dart';
import 'package:iptv/model/sqlite/utils/Comum.dart';
import 'package:iptv/model/sqlite/utils/TabelaCliente.dart';
import 'package:iptv/model/sqlite/utils/TabelaUsuario.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

class Cliente extends Usuario{
  String? _dataVencimento;
  int? _adm; //1-n com adm.
  

 Cliente.fromMapSqLite(Map map) {
    id = map[TabelaUsuario.COL_ID];
    nome = map[TabelaUsuario.COL_NOME];
    codigo = map[TabelaUsuario.COL_CODIGO];
    login = map[TabelaUsuario.COL_LOGIN];
    senha = map[TabelaUsuario.COL_SENHA];
    setUrlFoto = map[TabelaUsuario.COL_URLFOTO];
    _dataVencimento = map[TabelaCliente.COL_DATAVENCIMENTO];
    _adm = map[TabelaCliente.COL_ADM];
    status = map[TabelaUsuario.COL_STATUS];
  }
   Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
    TabelaUsuario.COL_ID:id,
    TabelaUsuario.COL_NOME:  nome,
    TabelaUsuario.COL_CODIGO:codigo,
    TabelaUsuario.COL_LOGIN:  login,
    TabelaUsuario.COL_SENHA: senha,
    TabelaUsuario.COL_URLFOTO:getUrlFoto,
    TabelaCliente.COL_DATAVENCIMENTO:  _dataVencimento,
    TabelaCliente.COL_ADM: _adm,
    TabelaUsuario.COL_STATUS:status 
    };
    return map;
  }

  Cliente(int id, String nome, String codigo, String login, String senha){
    this.id = id;
    this.nome = nome;
    this.codigo = codigo;
    this.login = login;
    this.senha = senha;
  }
  Cliente.internal();
  Cliente.full(String nome, String codigoh, String login, String senha,String data, int idadm){
   // this.id = id==0?null:id;
   
    this.nome = nome;
    this.codigo = codigoh;
    this.login = login;
    this.senha = senha;
    this._dataVencimento = data;
    this._adm = idadm;
  }
    
  
  //Cliente();
  //getters e setters
  String? get dataVencimento => this._dataVencimento;
  set dataVencimento(String? value) => this._dataVencimento = value;

  int? get adm => this._adm;
  set adm(int? value) => this._adm = value; 


  //metodos de acesso ao bd.
  Future insert() async {
    Database dataBase = await SqlHelper().db;
    //insere adm tbm e pega o retorno. se 0 ou null. já existe.
    int valor = 0;
    try{
      valor = await dataBase.insert(TabelaCliente.NOME_TABELA, toMap());
      print("ID Cliente: "+valor.toString());
    }catch(ex){
       print('Failed to insert: ' + ex.toString());
       throw Exception("Class Cliente L:79 "+ex.toString());
    }
    return valor;
  }
    /// *Retorna todos os clientes.*
    static Future<List<Cliente>> getAll() {
    return Future<List<Cliente>>.delayed(Duration(seconds: 1), () async {
      Database dataBase = await SqlHelper().db;
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

}