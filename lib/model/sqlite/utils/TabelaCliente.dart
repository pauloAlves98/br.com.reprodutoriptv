import 'TabelaAdministrador.dart';
import 'TabelaUsuario.dart';

class TabelaCliente{

  static const String NOME_TABELA = "cliente";
  static const String COL_DATAVENCIMENTO = "datavencimento";
  static const String COL_ADM = "fkAdm"; //1-n com adm.

  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
  TabelaUsuario.COL_ID + " INTEGER PRIMARY KEY, "+
  TabelaUsuario.COL_NOME + " TEXT, "+
  TabelaUsuario.COL_CODIGO + " TEXT, "+
  TabelaUsuario.COL_LOGIN + " TEXT, "+
  TabelaUsuario.COL_SENHA + " TEXT, "+
  TabelaUsuario.COL_STATUS +  " TEXT, "+
  TabelaUsuario.COL_URLFOTO + " TEXT, " +
  "$COL_ADM INTEGER, "+
  "$COL_DATAVENCIMENTO TEXT, "+ 
  "FOREIGN KEY($COL_ADM) REFERENCES "+ TabelaAdministrador.NOME_TABELA+"("+TabelaUsuario.COL_ID+"));";
}