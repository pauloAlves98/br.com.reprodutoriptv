import 'package:iptv/model/bin/Administrador.dart';
import 'package:iptv/model/bin/Usuario.dart';

class Cliente extends Usuario{
  String? _dataVencimento;
  Administrador? _adm; //1-n com adm.
  


  Cliente(int? id, String nome, String codigo, String login, String senha) : super(id, nome, codigo, login, senha);
  
  //getters e setters
  String? get dataVencimento => this._dataVencimento;
  set dataVencimento(String? value) => this._dataVencimento = value;

  Administrador? get adm => this._adm;
  set adm(Administrador? value) => this._adm = value; 

  //metodos de conversão

  //metodos de acesso ao bd.

}