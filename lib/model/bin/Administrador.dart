import 'Usuario.dart';

class Administrador extends Usuario{
  bool _superuser = false;

  Administrador(int? id, String nome, String codigo, String login, String senha) : super(id, nome, codigo, login, senha);
  

  bool get superuser => this._superuser;
  set superuser(bool value) => this._superuser = value;
  
  //metodos de conversão

  //metodos de acesso ao bd.

}