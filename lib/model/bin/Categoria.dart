import 'dart:io';

import 'package:iptv/model/sqlite/utils/TabelaCategoria.dart';

class Categoria {
  int? _id;
  String? _nome;
  String? _status = "ATIVA";

  //metodos de conversão
  Categoria.fromMapSqLite(Map map) {
    _id = map[TabelaCategoria.COL_ID];
    _nome = map[TabelaCategoria.COL_NOME];
    _status = map[TabelaCategoria.COL_STATUS];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      TabelaCategoria.COL_ID: _id,
      TabelaCategoria.COL_NOME: _nome,
      TabelaCategoria.COL_STATUS: _status
    };
    return map;
  }

  // GETTERS E SETTERS
  int? get id => this._id;
  set id(int? value) => this._id = value;
  //
  get nome => this._nome;
  set nome(value) => this._nome = value;

  //extrair categorias

  @override
  bool contains(Object element) {
  element = element as Categoria;
  return element.nome == this.nome?true:false;
}
  Future<List<dynamic>?> carregaCategoria(String caminhoArq) async {//extrai categorias da lista.
    //lançar exceçoe personalizadas
    List<String> categorias = ["SEM CATEGORIA"];
    List categoriasAux = [];
    try {
      File file = new File(caminhoArq);
      categoriasAux = await file.readAsLines();
      categoriasAux.forEach((line) {
        if (line.trim().length > 0 &&
            line.trimLeft().substring(0, 7) == "#EXTINF" &&
            line.trimLeft().contains('group-title')) {
          RegExp regexgrupo = RegExp(r'group-title[\s]*[=][\s]*"[^"]*"');
          String grupo = regexgrupo.stringMatch(line).toString();
          grupo = grupo.replaceAll(RegExp(r'group-title[\s]*[=][\s]*'), '');
          grupo = grupo.replaceAll('"', "");
          if (!categorias.contains(grupo)) categorias.add(grupo);
        }
      });
    } catch (e) {
      throw new Exception(//complentar o metodo.//verificar como o contains faz a comparação
          "Erro ao ler arquivo classe categoria : " + e.toString());
    }
    return categorias;
  }
  //metodos de acesso ao bd.

}
