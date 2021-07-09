import 'package:iptv/model/bin/Cliente.dart';

class Lista{
  int? _id;
  String? _nome;
  String? _link;//endreco da lista.
  Cliente? _cliente;//UM CLIENTE PODE CARREGAR MAIS DE UMA LISTA
	String? _datamodificacao;
	String? _status;
  

  //getter e setter
  get id => this._id;
  set id( value) => this._id = value;

  get nome => this._nome;
  set nome( value) => this._nome = value;

  get link => this._link;
  set link( value) => this._link = value;

 	String? get datamodificacao => this._datamodificacao;
  set datamodificacao(	String? value) => this._datamodificacao = value;

 	String? get status => this._status;
  set status(	String? value) => this._status = value;
  //metodos de conversão

  //metodos de acesso ao bd.
}