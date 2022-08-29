import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/bin/Canal.dart';
import 'package:iptv/repository/DTO/CanalDTO.dart';
import '../../main.dart';
import '../../model/utils/Constantes.dart';
import '../../model/utils/Corrente.dart';

class PesquisaPage extends StatefulWidget {
  const PesquisaPage({Key? key}) : super(key: key);

  @override
  State<PesquisaPage> createState() => _PesquisaPageState();
}

class _PesquisaPageState extends State<PesquisaPage> {
  String searchString = "";
  CanalDTO? canalDTO = CanalDTO.instance;
  TextEditingController searchControl = TextEditingController();
  // late Future<List<Canal>> shows;
  @override
  void initState() {
    super.initState();
    //Caso Alguma Lista Esteja Carregada!
    // shows = (Corrente.listaCorrente != null
    //     ? canalDTO?.getAllLista(Corrente.listaCorrente.id)
    //     : canalDTO?.getAllLista(-100))!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            controller: searchControl,
            style: TextStyle(color: Colors.white),
            onChanged: (value) {},
            decoration: InputDecoration(
                labelStyle: TextStyle(color: AZUL_ALTERNATIVO),
                iconColor: Colors.white,
                labelText: 'Pesquisar',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      searchString = searchControl.text.toLowerCase();
                    });
                  },
                )),
            onSubmitted: (value) {
              setState(() {
                searchString = value.toLowerCase();
              });
            },
          ),
        ),
        SizedBox(height: 2),
        Expanded(
          child: Corrente.listaCorrente != null
              ? FutureBuilder(
                  future:  (Corrente.listaCorrente != null
                          ? canalDTO?.getCanaisPorParametro(
                              Corrente.listaCorrente.id, searchString)
                          : canalDTO?.getCanaisPorParametro(
                              -10, searchString))!,
                  builder: (context, AsyncSnapshot<List<Canal>> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.length > 0
                          ? Center(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(16.0),
                                        color: Color.fromARGB(60, 0, 0, 0),
                                      ),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        leading: CircleAvatar(
                                          child: Tooltip(
                                            message: "Executar",
                                            child: IconButton(
                                              icon: Icon(
                                                  Icons.play_arrow_outlined),
                                              onPressed: () {
                                                Corrente.canalCorrente =
                                                    snapshot.data![index]
                                                        as Canal;
                                                Navigator.pushNamed(
                                                    context, EXIBIRCANALPAGE);
                                              },
                                            ),
                                          ),
                                        ),

                                        title: Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              Corrente.canalCorrente = snapshot
                                                  .data![index] as Canal;
                                              Navigator.pushNamed(
                                                  context, EXIBIRCANALPAGE);
                                            },
                                            child: Text(
                                              '${snapshot.data?[index].nome}',
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.oswald(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // subtitle: Text(
                                        //     'Cat ID: ${snapshot.data?[index].idcategoria}'),
                                      ),
                                    ),
                                  );
                                },
                                // separatorBuilder:
                                //     (BuildContext context, int index) {
                                //   return Container();
                                // },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, left: 4, right: 4),
                              child: Align(
                                child: Text("Nenhum Canal encontrado para:$searchString",
                                    style: GoogleFonts.oswald(
                                      color: AZUL_ALTERNATIVO,
                                      fontSize: 23,
                                    )),
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro ao Carregar Lista!'));
                    } else
                      return Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 50, left: 4, right: 4),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 50, left: 4, right: 4),
                  child: Align(
                    child: Text("Nenhuma lista Carregada!",
                        style: GoogleFonts.oswald(
                          color: AZUL_ALTERNATIVO,
                          fontSize: 23,
                        )),
                  ),
                ),
        ),
      ],
    );
  }
}
