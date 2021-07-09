import 'package:iptv/model/bin/Lista.dart';

class Canal {
  int? id;
  String? _nome;
  String? _linkLogo;
  String? _linkVideo;
  String? _status;
  Lista? _lista;//CANAL PERTENECE A UMA LISTA SÓ MAIS UMA LISTA PODE ESTAR EM VARIOS CANAIS
  
  get getId => this.id;
  set setId( id) => this.id = id;

  get nome => this._nome;
  set nome( value) => this._nome = value;

  get linkLogo => this._linkLogo;
  set linkLogo( value) => this._linkLogo = value;

  get linkVideo => this._linkVideo;
  set linkVideo( value) => this._linkVideo = value;

  get status => this._status;
  set status( value) => this._status = value;

  get lista => this._lista;
  set lista( value) => this._lista = value;

  //metodos de conversão

  //metodos de acesso ao bd.

}