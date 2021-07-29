import 'TabelaLista.dart';

class TabelaCategoria{
  static const String NOME_TABELA = "categoria";
  static const String COL_ID = "id";
  static const String COL_NOME = "nome";
  static const String COL_STATUS = "status";
  static const String COL_LISTA = "fkLista";
  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
   "$COL_ID INTEGER PRIMARY KEY, "+
   "$COL_NOME TEXT, "+
   "$COL_LISTA INTEGER NOT NULL, "+ 
   "$COL_STATUS TEXT, "+
    "FOREIGN KEY($COL_LISTA) REFERENCES "+ TabelaLista.NOME_TABELA+"("+TabelaLista.COL_ID+"));";


  static String getAllPorNome(String nome, int idlista) {
    return "SELECT * FROM $NOME_TABELA where $COL_NOME='$nome' and $COL_LISTA='$idlista'";
  }

  static String getAllLista(int idlista) {
    String auxid = idlista.toString();
    return "SELECT * FROM $NOME_TABELA where $COL_LISTA='$auxid'";
  }

static String removeAllLista(int idlista) {
    return "DELETE FROM $NOME_TABELA where $COL_LISTA='$idlista'";
  }
   static String getCountCategoriasPorLista(int idlista) {
    String id = idlista.toString();
    return "SELECT count(DISTINCT $COL_ID) FROM $NOME_TABELA where $COL_LISTA = $id";
  }
}