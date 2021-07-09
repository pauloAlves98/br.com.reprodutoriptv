import 'package:iptv/model/bin/Canal.dart';
import 'package:iptv/model/bin/Categoria.dart';

class CategoriaXcanais {
  int? id;
  Categoria _categoria;
  Canal _canal;
  String? _status;
  
  CategoriaXcanais(this._categoria, this._canal);
 
 
  int? get getId => this.id;
  set setId(int? id) => this.id = id;

  get categoria => this._categoria;
  set categoria( value) => this._categoria = value;

  get canal => this._canal;
  set canal( value) => this._canal = value;

  get status => this._status;
  set status( value) => this._status = value;

	//metodos de conversão

  //metodos de acesso ao bd.
}