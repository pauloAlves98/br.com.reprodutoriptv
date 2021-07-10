import 'TabelaCliente.dart';
import 'TabelaUsuario.dart';

class TabelaLista{

  static const String NOME_TABELA = "lista";
  static const String COL_ID = "id";
  static const String COL_NOME = "nome";
  static const String COL_LINK = "link";//endreco da lista.
  static const String COL_CLIENTE ="fkCliente";//UM CLIENTE PODE CARREGAR MAIS DE UMA LISTA
	static const String COL_DATAMODIFICACAO = "datamodificacao";
  static const String COL_STATUS = "status";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "+
   "$COL_ID INTEGER PRIMARY KEY, "+
   "$COL_NOME TEXT, "+
   "$COL_LINK TEXT, "+
   "$COL_DATAMODIFICACAO TEXT, "+
   "$COL_STATUS TEXT, "+
   "$COL_CLIENTE INTEGER, "+ 
   "FOREIGN KEY($COL_CLIENTE) REFERENCES "+ TabelaCliente.NOME_TABELA+"("+TabelaUsuario.COL_ID+"));";

}