import 'dart:io';

import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/model/sqlite/SqlHelper.dart';
import 'package:iptv/model/sqlite/utils/TabelaCanal.dart';
import 'package:sqflite/sqflite.dart';

import 'Categoria.dart';

class Canal {
  int? _id;
  String? _nome;
  String? _linkLogo;
  String? _linkVideo;
  String? _status = 'ATIVO';
  int? _idlista;
  //CANAL PERTENCE A UMA LISTA SÓ MAIS UMA LISTA
  int? _idcategoria;

  Canal();
  Canal.simples(String nome, String logo, String video) {
    this._nome = nome;
    this._linkLogo = logo;
    this._linkVideo = video;
  }
  Canal.parcial(String nome, String logo, String video, int idcategoria) {
    this._nome = nome;
    this._linkLogo = logo;
    this._linkVideo = video;
    this._idcategoria = idcategoria;
  }

  static const String SEM_LOGO = "SEM_LOGO";
  //metodos de conversão
  Canal.fromMapSqLite(Map map) {
    _id = map[TabelaCanal.COL_ID];
    _nome = map[TabelaCanal.COL_NOME];
    _linkLogo = map[TabelaCanal.COL_LINKLOGO];
    _linkVideo = map[TabelaCanal.COL_LINKVIDEO];
    _idlista = map[TabelaCanal.COL_LISTA];
    _idcategoria = map[TabelaCanal.COL_CATEGORIA];
    _status = map[TabelaCanal.COL_STATUS];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      TabelaCanal.COL_ID: _id,
      TabelaCanal.COL_NOME: _nome,
      TabelaCanal.COL_LINKLOGO: _linkLogo,
      TabelaCanal.COL_LINKVIDEO: _linkVideo,
      TabelaCanal.COL_LISTA: _idlista,
      TabelaCanal.COL_CATEGORIA: _idcategoria,
      TabelaCanal.COL_STATUS: _status
    };
    return map;
  }

  get idlista => this._idlista;
  set idlista(value) => this._idlista = value;

  int? get idcategoria => this._idcategoria;
  set idcategoria(int? value) => this._idcategoria = value;

  get getId => this._id;
  set setId(id) => this._id = id;

  get nome => this._nome;
  set nome(value) => this._nome = value;

  get linkLogo => this._linkLogo;
  set linkLogo(value) => this._linkLogo = value;

  get linkVideo => this._linkVideo;
  set linkVideo(value) => this._linkVideo = value;

  get status => this._status;
  set status(value) => this._status = value;

  static Future<List<Canal>?> carregaCanais(List<dynamic> lista, int idlista) async {
    //lista vinda do metodo carrega lista de Lista.
    //lançar exceçoe personalizadas
    List<Canal> canais = [];
    print("EXEcutar canias");
    try {
      for (dynamic line in lista) {//for each nao funfa bem com future;
    
        String extinf = line[0];
        String http = line[1];
       
        String? nome =
            extinf.replaceAll(RegExp(r'[^]+,'), '').trimLeft().length <= 0
                ? "SEM NOME"
                : extinf.replaceAll(RegExp(r'[^]+,'), '');
        String linkLogo = SEM_LOGO;
        String linkVideo = http;
        int? idcategoria;

        String categoria = Categoria.SEM_CATEGORIA;

        if (extinf.contains('tvg-logo')) {
          RegExp regexlogo = RegExp(r'tvg-logo[\s]*[=][\s]*"[^"]*"');
          String logo = regexlogo.stringMatch(extinf).toString();
          logo = logo.replaceAll(RegExp(r'tvg-logo[\s]*[=][\s]*'), '');
          logo = logo.replaceAll('"', "");
          linkLogo = logo.length <= 0 ? SEM_LOGO : logo;
        }
        if (extinf.trimLeft().contains('group-title')) {
          RegExp regexgrupo = RegExp(r'group-title[\s]*[=][\s]*"[^"]*"');
          String grupo = regexgrupo.stringMatch(extinf).toString();
          grupo = grupo.replaceAll(RegExp(r'group-title[\s]*[=][\s]*'), '');
          grupo = grupo.replaceAll('"', "").trimLeft();
          grupo = grupo.length <= 0 ? Categoria.SEM_CATEGORIA : grupo;
          categoria = grupo;
        }
        //consultar categoria;
        List<Categoria> c = await Categoria.getAllPorNome(categoria, idlista);
        if (c.length <= 0) idcategoria = await Categoria.simples(categoria, idlista).insert();
        else idcategoria = c[0].id;
        
         //print("Video: "+linkVideo);
        canais.add(new Canal.parcial(nome, linkLogo, linkVideo, idcategoria!));
      }
    } catch (e) {
      throw new Exception(//criar exception personalisadas
          "Erro ao ler arquivo classe canais : " + e.toString());
    }
    print("Saiu de canais l:126"); //printa primeiro, pois metodos async eh pulado.
    return canais;
  }

  //metodos de acesso ao bd.
  Future insert() async {
    Database dataBase = await SqlHelper().db;
    int valor = await dataBase.insert(TabelaCanal.NOME_TABELA, toMap());
    //print("Canal $nome ID: " + valor.toString());
    //print("Link video");
    //print(linkVideo);
    return valor;
  }

  static Future<int> getCountCanaisPorLista(int idlista)  {
    return Future<int>.delayed(Duration(seconds: 0), () async {
      Database dataBase = await SqlHelper().db;
      List listMap = await dataBase.rawQuery(TabelaCanal.getCountCanaisPorLista(idlista));
      int total = 0;
      print("Contando Canais em Canal.dart L: 145");
      for (Map m in listMap) {
        //print(m.keys);
        total = m['count(id)'] != null ? m['count(id)'] : 0;
        // pagamentos.add(Pagamento.fromMapSqLite(m));
      }
      print("Total de Canais em Canal.dart L: 151:"+total.toString());
      return total;
    });
  }

    static Future<int> getCountCategoriasPorLista(int idlista) {
    return Future<int>.delayed(Duration(seconds: 0), () async {
      Database dataBase = await SqlHelper().db;
      List listMap = await dataBase.rawQuery(TabelaCanal.getCountCategoriasPorLista(idlista));
      int total = 0;
      String tbcat  = TabelaCanal.COL_CATEGORIA;
      for (Map m in listMap) {//pra ler o map.
        print(m.keys);
        total = m['count(DISTINCT $tbcat)'] != null ? m['count(DISTINCT $tbcat)'] : 0;
        // pagamentos.add(Pagamento.fromMapSqLite(m));
      }
      print("Total:"+total.toString());
      return total;
    });
  }

    static Future<List<Canal>> getAllCategoria(int? idcat) async {//close no banco
    Database dataBase = await SqlHelper().db;
    List listMap = await dataBase.rawQuery(TabelaCanal.getAllCategoria(idcat!));
    print("ID de busca categoria: "+idcat.toString());
    List <Canal> categorias = [];
    for (Map m in listMap) {
        categorias.add(Canal.fromMapSqLite(m));
    }
    return categorias;
  }
}
