
import 'TabelaUsuario.dart';

class TabelaAdministrador{

  static const String NOME_TABELA = "administrador";
  static const String COL_SUPERUSER = "superuser";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
    TabelaUsuario.COL_ID + " INTEGER PRIMARY KEY, "+
    TabelaUsuario.COL_NOME + " TEXT, "+
    TabelaUsuario.COL_CODIGO + " TEXT UNIQUE, "+
    TabelaUsuario.COL_LOGIN + " TEXT, "+
    TabelaUsuario.COL_SENHA + " TEXT, "+
    TabelaUsuario.COL_STATUS +  " TEXT, "+
    TabelaUsuario.COL_URLFOTO + " TEXT, " +
    COL_SUPERUSER + " INTEGER);"; //"0 OU 1"

    //scripts;
}