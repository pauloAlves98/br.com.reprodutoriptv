import 'TabelaLista.dart';

class TabelaCanal{
  static const String NOME_TABELA = "canal";
  static const String COL_ID = "id";
  static const String COL_NOME = "nome";
  static const String COL_LINKLOGO = "linkLogo";
  static const String COL_LINKVIDEO = "linkVideo";
  static const String COL_STATUS = "status";
  static const String COL_LISTA = "fkLista";//CANAL PERTENECE A UMA LISTA SÓ MAIS UMA LISTA 

  
  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
   "$COL_ID INTEGER PRIMARY KEY, "+
   "$COL_NOME TEXT, "+
   "$COL_LINKLOGO TEXT, "+
   "$COL_LINKVIDEO TEXT, "+
   "$COL_STATUS TEXT, "+
   "$COL_LISTA INTEGER, "+ 
   "FOREIGN KEY($COL_LISTA) REFERENCES "+ TabelaLista.NOME_TABELA+"("+TabelaLista.COL_ID+"));";

}