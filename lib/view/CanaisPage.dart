import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/main.dart';
import 'package:iptv/model/bin/Canal.dart';
import 'package:iptv/model/bin/Categoria.dart';
import 'package:iptv/model/utils/Constantes.dart';
import 'package:iptv/model/utils/Corrente.dart';
import 'package:iptv/view/ExibirCanalPage.dart';

class CanaisPage extends StatefulWidget {
   CanaisPage();
  @override
  _CanaisPageState createState() => _CanaisPageState();
}

class _CanaisPageState extends State<CanaisPage> {
  bool issearch = false;
  @override
  Widget build(BuildContext context) {
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

  Widget bilderHeaderCategorias(List<Categoria> categorias) {
    List<Widget> filhos = [];
    for (Categoria cat in categorias){
         filhos.add(builderCardCategoria(cat));
    }
    return ListView(
      children: filhos,
    );
  }

  Widget builderCardCategoria(Categoria categoria) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Container(
              //color: Colors.red,
              height: 50,
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                          categoria.nome.length > 20
                              ? categoria.nome
                                  .substring(0, 20)
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
                        print("Clicou");
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
            child:  FutureBuilder(
                    future:  builderAllCanais(categoria),
                    //initialData :"Aguardando os dados...",

                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //concluido
                        // suc = true;
                        
                        // if(widget.widgets.isEmpty)
                        //   return Padding(
                        //     padding: const EdgeInsets.only(top: 50,left: 4,right: 4),
                        //     child: Align(
                              
                        //       child: Text("Nenhum Canal encontrado",style: GoogleFonts.oswald(
                        //                 color: AZUL_ALTERNATIVO, fontSize: 23,
                        //                 )),
                        //     ),
                        //   );
                        return snapshot.data as Widget;
                      } else if (snapshot.error != null) {
                        print("ERROOO");
                        print(snapshot.error);
                        
                           
                        return Container(
                          //decoration: box(),
                          child: Center(
                            child: Text(
                               "Erro ao carregar canais: "+snapshot.error.toString(),
                                style: GoogleFonts.roboto(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold)),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
          ),
        ],
      ),
    );
  }
    Future<Widget> builderAllCanais(Categoria categoria) async {
    List<Widget> filhos = [];
    List<Canal> canais = await Canal.getAllCategoria(categoria.id);
    print("Canais:");
    print(canais .length.toString());
    for (Canal can in canais){
      //print(can.nome);
        filhos .add(builderCardCanal(can));
    }
 
    return ListView(
      scrollDirection: Axis.horizontal,
      children: filhos,
    );
  }

  Widget builderCardCanal(Canal canal) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                Color.fromRGBO(0, 0, 0, 0.8), BlendMode.srcOver),
            image: Constantes.USER_ASSET,
          ),
        ),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Color.fromRGBO(0, 0, 0, 0.8), BlendMode.srcOver),
              image: 
              NetworkImage(
                  canal.linkLogo==Canal.SEM_LOGO?'https://lh3.googleusercontent.com/proxy/yAQO7IIGGbk-FaiXl4CH76fZwrxykMSMlpcFQqla7odoCnYfyeRakda4TVrrTLbMU-RwQnhaEj75-3__Pz9lUG-BkrRVO_nm_O1Gi6HyITiEIS9FlPKKaaKNoHBkG2QIz2mYRfQuJBuFflcHRkb_ysFW0RXmsBdgCwVNk3Fs_RyEud_m6MgA': canal.linkLogo
              ),
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
                      Navigator.pushReplacementNamed(context, EXIBIRCANALPAGE);
                      //dispose();
                    },
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
