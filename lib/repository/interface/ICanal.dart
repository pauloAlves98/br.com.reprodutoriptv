
import '../../model/bin/Canal.dart';

abstract class ICanal {

  Future insert(Canal canal);
  /// *Retorna o número de canais vinculados a uma lista.*
  Future<int> getCountCanaisPorLista(int idlista);
  /// *Retorna todos os canais vinculados a uma categoria.*
  Future<List<Canal>> getAllCategoria(int? idcat);
  Future<List<Canal>> getAllLista(int? idcat); 
  /// Retorna uma Lista de canais, extraidos de um vetor de dados obitidos de uma lista.
  /// 
  /// Atenção: Esse método está vinculado a operações com o bd para inserções de categorias não existentes.
  /// 
  ///**Lista lista**: *Lista  de [[string contendo informações do Extinf, String contendo Informações do http]] *
  ///
  ///**Lista lista**: *Id da Lista vinculada aos canais.*
  // Future<List<Canal>?> carregarCanais();

}