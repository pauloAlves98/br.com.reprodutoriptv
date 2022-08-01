

import '../../model/bin/Lista.dart';

abstract class ILista  {
  ///**nome**: *nome da lista*
  ///
  ///**caminho**: *caminho da lista no dispositivo*
  ///
  ///**caminho**: *id do cliente que essa lista ficara vinculada*
  Future insert(Lista lista);
   /// *Retorna todas as listas vinculadas a um cliente.*
  Future<List<Lista>> getAllCliente(int id);
  /// *Deleta todas as categorias e canais vinculados a uma lista, incluindo a lista!*
  Future<List<dynamic>> deleteCascade(int idlist);
  
}