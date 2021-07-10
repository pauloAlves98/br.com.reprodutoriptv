class TabelaCategoria{
  static const String NOME_TABELA = "categoria";
  static const String COL_ID = "id";
  static const String COL_NOME = "nome";
  static const String COL_STATUS = "status";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
   "$COL_ID INTEGER PRIMARY KEY, "+
   "$COL_NOME TEXT, "+
   "$COL_STATUS TEXT);";
}