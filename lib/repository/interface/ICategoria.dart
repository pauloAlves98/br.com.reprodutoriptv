


import '../../model/bin/Categoria.dart';

abstract class ICategoria {

  Future insert(Categoria categoria);
  /// *Insere várias categorias de uma única vez. Utiliza inserção em Lotes.*
  Future<List<dynamic>> insertAll(List<Categoria> categorias);
  /// *Retorna todas as categorias com o nome destacado no parâmetro.*
  Future<List<Categoria>> getAllPorNome(String nome, int idlista);
  /// *Retorna todas as categorias vinculadas a uma lista.*
  Future<List<Categoria>> getAllLista(int idlista);
  /// *Retorna o número de categorias vinculadas a uma lista.*
  Future<int> getCountCategoriasPorLista(int idlista);
  /// *Carregar categorias* Talvez isso não seja aqui.
  // Future<List<Categoria>?> carregarCategoria();

}