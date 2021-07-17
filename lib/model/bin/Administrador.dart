import 'package:iptv/model/sqlite/SqlHelper.dart';
import 'package:iptv/model/sqlite/utils/TabelaAdministrador.dart';
import 'package:iptv/model/sqlite/utils/TabelaUsuario.dart';
import 'package:sqflite/sqflite.dart';

import 'Usuario.dart';

class Administrador extends Usuario{
  int _superuser = 0;

  //Administrador(int? id, String nome, String codigo, String login, String senha) : super(id, nome, codigo, login, senha);
  Administrador(int id, String nome, String codigo, String login, String senha){
    this.id = id;
    this.nome = nome;
    this.codigo = codigo;
    this.login = login;
    this.senha = senha;
  }
  Administrador.fromMapSqLite(Map map) {
    id = map[TabelaUsuario.COL_ID];
    nome = map[TabelaUsuario.COL_NOME];
    codigo = map[TabelaUsuario.COL_CODIGO];
    login = map[TabelaUsuario.COL_LOGIN];
    senha = map[TabelaUsuario.COL_SENHA];
    setUrlFoto = map[TabelaUsuario.COL_URLFOTO];
    _superuser = map[TabelaAdministrador.COL_SUPERUSER];
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
    TabelaAdministrador.COL_SUPERUSER:   _superuser,
    TabelaUsuario.COL_STATUS:status 
    };
    return map;
  }


  int get superuser => this._superuser;
  set superuser(int value) => this._superuser = value;
  
  //metodos de conversão

  //metodos de acesso ao bd.
 Future insert() async {
    Database dataBase = await SqlHelper().db;
    //insere adm tbm e pega o retorno. se 0 ou null. já existe.
     int valor = 0;
    try{
      valor = await dataBase.insert(TabelaAdministrador.NOME_TABELA, toMap());
      print("ID ADM: "+valor.toString());
    }catch(ex){
       print('Failed to insert: ' + ex.toString());
    }
   
    return valor;
  }
}