import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/main.dart';
import 'package:iptv/model/bin/Canal.dart';
import 'package:iptv/model/bin/Categoria.dart';
import 'package:iptv/model/utils/Constantes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/model/utils/Corrente.dart';
import 'package:iptv/repository/DTO/CanalDTO.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:optimized_cached_image/optimized_cached_image.dart';
// ignore: import_of_legacy_library_into_null_safe

class CanaisPage extends StatefulWidget {
  CanaisPage();
  @override
  _CanaisPageState createState() => _CanaisPageState();
}

class _CanaisPageState extends State<CanaisPage> {
  bool issearch = false;
  CanalDTO? canalDTO = CanalDTO.instance;

  @override
  Widget build(BuildContext context) {
    // utiliza Categoria corrente para veiricações!
    return Corrente.categoriasCorrente != null &&
            Corrente.categoriasCorrente.isNotEmpty
        ? bilderHeaderCategorias(Corrente.categoriasCorrente)
        : Padding(
            padding: const EdgeInsets.only(top: 50, left: 4, right: 4),
            child: Align(
              child: Text("Nenhuma lista Carregada!",
                  style: GoogleFonts.oswald(
                    color: AZUL_ALTERNATIVO,
                    fontSize: 23,
                  )),
            ),
          );
  }

  /// Cria o cabeçario de categoria com o nome e deixa o espaço para inserção do widget de execução!
  Widget bilderHeaderCategorias(List<Categoria> categorias) {
    List<Widget> filhos = [];
    for (Categoria cat in categorias) {
      filhos.add(builderCardCategoria(cat));
    }
    return ListView(
      children: filhos,
    );
  }

  /// Renderiza as informações das Categorias e do canal dentro do header de categoria!
  Widget builderCardCategoria(Categoria categoria) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Container(
              //color: Colors.red,
              height: 50, //epaço para o nome da categoria!
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                          categoria.nome.length > 20
                              ? categoria.nome.substring(0, 20)
                              : categoria.nome,
                          style: GoogleFonts.sairaCondensed(
                            color: Colors.white,
                            fontSize: 25,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: issearch
                          ? Icon(
                              Icons.arrow_upward,
                              color: AZUL_ALTERNATIVO,
                            )
                          : Icon(Icons.arrow_downward, color: AZUL_ALTERNATIVO),
                      onPressed: () {
                        //print("");
                        //Expnadir o canal no widget! não realizado.
                        setState(() {
                          if (issearch)
                            issearch = false;
                          else if (issearch == false) issearch = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150,
            child: FutureBuilder(
                future: builderAllCanais(context, categoria),
                //initialData :"Aguardando os dados...",

                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data
                        as Widget; // retorna lista de canais para esta categoria!
                  } else if (snapshot.error != null) {
                    print("ERRO - FutureBuilder - CanaisPage L:109");
                    print(snapshot.error);
                    return Container(
                      child: Center(
                        child: Text(
                            "Erro ao carregar canais: " +
                                snapshot.error.toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold)),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  ///Constrói os canais abaixo do nome da categoria! Estilo AmazonPrime!
  Future<Widget> builderAllCanais(context, Categoria categoria) async {

    List<Canal>? canais = await canalDTO?.getAllCategoria(categoria.id);
    print("Quantidade de Canais a carregar:");
    print(canais?.length.toString());
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: canais!.length,
        itemBuilder: (BuildContext context, int index) {
          return builderCardCanal(context, canais[index]);
        });
  }

  /// Método auxiliar de builderAllCanais! Executa a construção individual do componente de canal!
  ///
  /// O  Corrente.canalCorrente é atualizado ao clicar no player executar!
  Widget builderCardCanal(context, Canal canal) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Corrente.canalCorrente = canal;
          
          Navigator.pushNamed(context, EXIBIRCANALPAGE);
          //dispose();
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // image: DecorationImage(
            //   fit: BoxFit.fill,
            //   colorFilter: new ColorFilter.mode(
            //       Color.fromRGBO(0, 0, 0, 0.8), BlendMode.srcOver),
            //   image: Constantes.USER_ASSET,
            // ),
          ),
          child: OptimizedCacheImage(
            imageUrl: canal.linkLogo,
            imageBuilder: (context, imageProvider) => Container(
              //se tiver tudo ok no carregamento!
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Color.fromRGBO(0, 0, 0, 0.8), BlendMode.srcOver),
                  image: imageProvider,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  focusColor: Colors.black,
                  title: Text(
                    canal.nome.length > 20
                        ? canal.nome.substring(0, 20)
                        : canal.nome,
                    style: TextStyle(color: Colors.white),
                  ),
                  // subtitle: Text(
                  //   "test",
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  leading: CircleAvatar(
                    child: Tooltip(
                      message: "Executar",
                      child: IconButton(
                        icon: Icon(Icons.play_arrow_outlined),
                        onPressed: () {
                          Corrente.canalCorrente = canal;
                          Navigator.pushNamed(context, EXIBIRCANALPAGE);
                          //dispose();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
            //caso não carregue a imagem!
            errorWidget: (context, url, error) => Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Color.fromRGBO(0, 0, 0, 0.8), BlendMode.srcOver),
                  image: Constantes.NOT_FOUND_IMAGE,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  focusColor: Colors.black,
                  title: Text(
                    canal.nome.length > 20
                        ? canal.nome.substring(0, 20)
                        : canal.nome, //separar por catgoria e listar na tela.
                    style: TextStyle(color: Colors.white),
                  ),
                  // subtitle: Text(
                  //   "test",
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  leading: CircleAvatar(
                    child: Tooltip(
                      message: "Executar",
                      child: IconButton(
                        icon: Icon(Icons.play_arrow_outlined),
                        onPressed: () {
                          Corrente.canalCorrente = canal;
                          Navigator.pushNamed(context, EXIBIRCANALPAGE);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
