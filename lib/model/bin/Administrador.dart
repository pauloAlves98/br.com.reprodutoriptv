import 'Usuario.dart';

class Administrador extends Usuario{
  int _superuser = 0;

  Administrador(int? id, String nome, String codigo, String login, String senha) : super(id, nome, codigo, login, senha);
  

  int get superuser => this._superuser;
  set superuser(int value) => this._superuser = value;
  
  //metodos de conversão

  //metodos de acesso ao bd.

}