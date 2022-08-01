

import '../../model/bin/Cliente.dart';

abstract class ICliente {
   /// *Insere um cliente.*
   Future insert(Cliente cliente);
   /// *Retorna todos os clientes.*
   Future<List<Cliente>> getAll();
}
