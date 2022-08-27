import 'dart:io';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/model/sqlite/SqlHelper.dart';
import 'package:iptv/model/sqlite/utils/Comum.dart';
import 'package:iptv/model/sqlite/utils/TabelaCanal.dart';
import 'package:iptv/model/sqlite/utils/TabelaCategoria.dart';
import 'package:iptv/model/sqlite/utils/TabelaLista.dart';
import 'package:iptv/repository/DTO/CanalDTO.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../../repository/DTO/CategoriaDTO.dart';
import '../../repository/DTO/ListaDTO.dart';
import 'Canal.dart';
import 'Categoria.dart';

class Lista {
  int? _id;
  String? _nome;
  String? _link; //endreco da lista.
  int? _idcliente;
  //UM CLIENTE PODE CARREGAR MAIS DE UMA LISTA
  String? _datamodificacao;
  String? _status = "ATIVO"; //criar constantes

  Lista();

  Lista.simples(String nome, String link) {
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

  static Future<List<dynamic>?> carregaLista(
      String caminho //extrai um vetor de listas [[info, http]]    String caminho,
      ) async {
    //extrai linhas do arquivo da lista
    List lista = [];
    List listaAux = [];
    bool extinf = false; //verifica se eh extinf
    String temp = "";
    try {
      File file = new File(caminho);
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
            lista.add([temp.trimLeft(), line.trimLeft()]);
            temp = "";
            extinf = false;
            //Ja da pra inserir categorias aqui! Uma a Uma!"" Montar vetor categorias!
          }
        }
      });
    } catch (e) {
      throw new Exception("Erro ao ler arquivo classe lista : " + e.toString());
    }

    //insert lista aqui.
    return lista;
  }

  ///**nome**: *nome da lista*
  ///
  ///**caminho**: *caminho da lista no dispositivo*
  ///
  ///**caminho**: *id do cliente que essa lista ficara vinculada*
  static Future popularLista(String nome, String caminho, int idcliente) async {
    CanalDTO? canalDTO = CanalDTO.instance;
    CategoriaDTO? categoriaDTO = CategoriaDTO.instance;
    ListaDTO? listaDTO =  ListaDTO.instance;

    Lista listac = new Lista.simples(nome, caminho);
    listac.idcliente = idcliente;
    listac.datamodificacao =
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    List<Canal>? canais;
    try {

      List? lista = await Lista.carregaLista(caminho);
      listac.id = await listaDTO!.insert(listac);

      // List<Categoria>? categorias =
      //     await Categoria.carregaCategoria(lista!, listac.id);
      // print("TAMANHO CATEGORIA: " + categorias!.length.toString());
      // List? iall = await categoriaDTO!
      //     .insertAll(categorias); //lista de id isso tem q sair!
      // print("FIM LOAD CATEGORIA L: 119 CLASS LISTA:" + iall.length.toString());

      //Categorias são inseridas no momento dos canais!

      //Inserir Canais tudo em uma mesma função, pois irá reduzir um for!
      canais = await Canal.carregaCanais(lista!, listac.id);
      print("Load Canais:");
      print(canais!.length);

      print("Popular lista: rodando canais!  L: 126 CLASS LISTA");
      for (Canal element in canais) {
        // print(element.linkVideo);
        element.idlista = listac.id;
        await canalDTO?.insert(element);
      }
      print("FIM LOAD CANAIS L: 132 CLASS LISTA");
    } catch (e) {
      print("Popular Lista exception " + e.toString());
      throw Exception("Popular Lista exception: " + e.toString());
    }
    return canais;
  }

  static getAllCliente(id) {}

  //metodos de acesso ao bd.

}
