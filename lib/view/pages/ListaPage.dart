import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/model/utils/Constantes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/model/utils/Corrente.dart';

// ignore: import_of_legacy_library_into_null_safe
import '../../main.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../components/CardLista.dart';

class ListaPage extends StatefulWidget {
  static List<Widget> widgets = [];
  ListaPage();
  

  @override
  _ListaPageState createState() => _ListaPageState();
}

//Utiliza Corrente.clienteCorrente para printar seu nome! Utiliza Corrente.listasCorrente para verificar as listas já cadastradas!
class _ListaPageState extends State<ListaPage> {
  _ListaPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: GRADIENTE_BODY,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 2, left: 4, right: 4, bottom: 2),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: GRADIENTE_CABECARIO,
                  ),
                  child: FlexibleSpaceBar(
                    title: Text(
                      Corrente.clienteCorrente == null
                          ? "Sem nome"
                          : Corrente.clienteCorrente.nome.toString().length>20? Corrente.clienteCorrente.nome.toString().substring(0,20):Corrente.clienteCorrente.nome,
                      style: GoogleFonts.encodeSans(),
                    ), //dropdownbuttom e mostras as infon ao expandir
                  ),
                ),
                //bottom: Text("Teste"),
                backgroundColor: Colors.transparent,
                // expandedHeight: MediaQuery.of(context).size.height <= 400 ||
                //          MediaQuery.of(context).orientation == Orientation.landscape
                //      ? 80
                //      : 100,
                leading: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage: AssetImage(
                      'assets/user.png',
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Tooltip(
                      message: "Nova Lista",
                      child: IconButton(
                        icon: Icon(Icons.add_circle_outline_outlined),
                        onPressed: () {
                          Navigator.pushNamed(context, CADASTROLISTAPAGE);
                        },
                      ),
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Corrente.listasCorrente != null &&
                        Corrente.listasCorrente.length > 0
                    ? FutureBuilder(
                        future: _builderItems(Corrente.listasCorrente, context),
                        //initialData :"Aguardando os dados...",

                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //concluido
                            // suc = true;

                            return snapshot.data as Widget;
                          } else if (snapshot.error != null) {
                            print("ERROOO");
                            print(snapshot.error);
                            bool isCanal =
                                snapshot.error!.toString().contains("canal");
                            return Container(
                              //decoration: box(),
                              child: Center(
                                child: Text(
                                    isCanal
                                        ? "Não foi possivel inserir os Canais!"
                                        : "Erro ao carregar listas!!!",
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
                        })
                    : Container(
                      height: MediaQuery.of(context).size.height-200,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(top: 50, left: 4, right: 4),
                          child: Align(
                            child: Text("Nenhuma lista encontrada!",
                                style: GoogleFonts.oswald(
                                  color: AZUL_ALTERNATIVO,
                                  fontSize: 23,
                                )),
                          ),
                        ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Carrega as listas em Corrente.listasCorrente. Quando ocorre uma inserção ou deleção Corrente.listasCorrente é atualizada!
  Future<Widget> _builderItems(List<Lista> listas, context) async {
    ListaPage.widgets = [];
    for (int i = 0; i < listas.length; i++) {
      Lista l = listas[i];
      ListaPage.widgets.add(await builderCardLista(context, l));
    }
    return Column(
      children: ListaPage.widgets,
    );
  }
}
