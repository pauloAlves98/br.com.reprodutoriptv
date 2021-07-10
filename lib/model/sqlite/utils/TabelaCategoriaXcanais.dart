import 'TabelaCanal.dart';
import 'TabelaCategoria.dart';

class TabelaCategoriaXcanal{
  static const String NOME_TABELA = "categoriaxcanal";
  static const String COL_ID = "id";
  static const String COL_STATUS = "status";
  static const String COL_CATEGORIA = "fkcategoria";
  static const String COL_CANAL = "fkcanal";
 
  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
   "$COL_ID INTEGER PRIMARY KEY, "+
   "$COL_STATUS TEXT, "+
   "$COL_CATEGORIA INTEGER, "+ 
   "$COL_CANAL INTEGER, "+ 
   "FOREIGN KEY($COL_CATEGORIA) REFERENCES "+ TabelaCategoria.NOME_TABELA+"("+TabelaCategoria.COL_ID+"), "+
   "FOREIGN KEY($COL_CANAL) REFERENCES "+ TabelaCanal.NOME_TABELA+"("+TabelaCanal.COL_ID+"));";

}