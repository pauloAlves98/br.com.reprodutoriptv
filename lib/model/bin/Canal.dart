import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/model/sqlite/utils/TabelaCanal.dart';

class Canal {
  int? _id;
  String? _nome;
  String? _linkLogo;
  String? _linkVideo;
  String? _status;
  int? _idlista;//CANAL PERTENCE A UMA LISTA SÓ MAIS UMA LISTA 
  
  //metodos de conversão
 Canal.fromMapSqLite(Map map) {
    _id = map[TabelaCanal.COL_ID];
    _nome = map[TabelaCanal.COL_NOME];
    _linkLogo =  map[TabelaCanal.COL_LINKLOGO];
    _linkVideo =  map[TabelaCanal.COL_LINKVIDEO];
    _idlista =  map[TabelaCanal.COL_LISTA];
    _status = map[TabelaCanal.COL_STATUS];
  }
   Map toMap() {
    Map<String, dynamic> map = {
    TabelaCanal.COL_ID : _id,
    TabelaCanal.COL_NOME:_nome,
    TabelaCanal.COL_LINKLOGO: _linkLogo,
    TabelaCanal.COL_LINKVIDEO: _linkVideo,
    TabelaCanal.COL_LISTA: _idlista,
    TabelaCanal.COL_STATUS:_status
    };
    return map;
  }
  //metodos de acesso ao bd.
  get getId => this._id;
  set setId( id) => this._id = id;

  get nome => this._nome;
  set nome( value) => this._nome = value;

  get linkLogo => this._linkLogo;
  set linkLogo( value) => this._linkLogo = value;

  get linkVideo => this._linkVideo;
  set linkVideo( value) => this._linkVideo = value;

  get status => this._status;
  set status( value) => this._status = value;
 

}