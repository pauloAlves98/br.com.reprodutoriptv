import 'package:iptv/model/sqlite/utils/TabelaCategoria.dart';

import 'TabelaLista.dart';

class TabelaCanal{
  static const String NOME_TABELA = "canal";
  static const String COL_ID = "id";
  static const String COL_NOME = "nome";
  static const String COL_LINKLOGO = "linkLogo";
  static const String COL_LINKVIDEO = "linkVideo";
  static const String COL_STATUS = "status";
  static const String COL_LISTA = "fkLista";//CANAL PERTENECE A UMA LISTA SÓ MAIS UMA LISTA 
  static const String COL_CATEGORIA = "fkCategoria";
  
  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
   "$COL_ID INTEGER PRIMARY KEY, "+
   "$COL_NOME TEXT, "+
   "$COL_LINKLOGO TEXT, "+
   "$COL_LINKVIDEO TEXT, "+
   "$COL_STATUS TEXT, "+
   "$COL_LISTA INTEGER NOT NULL, "+ 
   "$COL_CATEGORIA INTEGER NOT NULL, "+ 
   "FOREIGN KEY($COL_LISTA) REFERENCES "+ TabelaLista.NOME_TABELA+"("+TabelaLista.COL_ID+"), "+
   "FOREIGN KEY($COL_CATEGORIA) REFERENCES "+ TabelaCategoria.NOME_TABELA+"("+TabelaCategoria.COL_ID+"));";

  static String getCountCanaisPorLista(int idlista) {
    String id = idlista.toString();
    return "SELECT count($COL_ID) FROM $NOME_TABELA where $COL_LISTA = $id";
  }
  static String getCountCategoriasPorLista(int idlista) {
    String id = idlista.toString();
    return "SELECT count(DISTINCT $COL_CATEGORIA) FROM $NOME_TABELA where $COL_LISTA = $id";
  }
  static String removeAllLista(int idlista) {
    return "DELETE FROM $NOME_TABELA where $COL_LISTA='$idlista'";
  }

}