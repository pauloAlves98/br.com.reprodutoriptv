import 'dart:convert';
import 'dart:io';

import 'package:iptv/model/bin/Cliente.dart';
import 'package:iptv/model/sqlite/SqlHelper.dart';
import 'package:iptv/model/sqlite/utils/TabelaLista.dart';
import 'package:sqflite/sqflite.dart';

class Lista {
  int? _id;
  String? _nome;
  String? _link; //endreco da lista.
  int? _idcliente;
   //UM CLIENTE PODE CARREGAR MAIS DE UMA LISTA
  String? _datamodificacao;
  String? _status = "ATIVO";

  Lista();

  Lista.simples(String nome, String link){
    this._nome = nome;
    this._link = link;
  }

  Lista.fromMapSqLite(Map map) {
    _id = map[TabelaLista.COL_ID];
    _nome = map[TabelaLista.COL_NOME];
    _link = map[TabelaLista.COL_LINK]; //endreco da lista.
    _idcliente = map[TabelaLista.COL_CLIENTE];
    _datamodificacao = map[TabelaLista.COL_DATAMODIFICACAO];
    _status = map[TabelaLista.COL_STATUS];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      TabelaLista.COL_ID: _id,
      TabelaLista.COL_NOME: _nome,
      TabelaLista.COL_LINK: _link, //endreco da lista.
      TabelaLista.COL_CLIENTE: _idcliente,
      TabelaLista.COL_DATAMODIFICACAO: _datamodificacao,
      TabelaLista.COL_STATUS: _status
    };
    return map;
  }

  //getter e setter
  int? get idcliente => this._idcliente;
  set idcliente(int? value) => this._idcliente = value;
  
  get id => this._id;
  set id(value) => this._id = value;

  get nome => this._nome;
  set nome(value) => this._nome = value;

  get link => this._link;
  set link(value) => this._link = value;

  String? get datamodificacao => this._datamodificacao;
  set datamodificacao(String? value) => this._datamodificacao = value;

  String? get status => this._status;
  set status(String? value) => this._status = value;
  //metodos de conversão

  Future<List<dynamic>?> carregaLista() async {//extrai linhas do arquivo da lista
    List lista = [];
    List listaAux = [];
    bool extinf = false; //verifica se eh extinf
    String temp = "";
    try {
      File file = new File(this.link);
      listaAux = await file.readAsLines();
      listaAux.forEach((line) {
        if (line.trim().length > 0 &&
            line.trimLeft().substring(0, 7) == "#EXTINF") {
          //verifica se tem extinf.
          extinf = true;
          temp = line; //guarda linha com dados.
        } else if (line.trim().length > 0 &&
            line.trimLeft().substring(0, 4) == "http") {
          //verifica se tem http na proxima linha util:
          if (extinf) {
            lista.add([temp, line]);
            temp = "";
            extinf = false;
          }
        }
      });
    } catch (e) {
        throw new Exception("Erro ao ler arquivo classe lista : " + e.toString());
    }

    //insert lista aqui.
    return lista;
  }

  //metodos de acesso ao bd.
  Future insert() async {
    Database dataBase = await SqlHelper().db;
    int valor = await dataBase.insert(TabelaLista.NOME_TABELA, toMap());
    print(valor);
    return valor;
  }
}
